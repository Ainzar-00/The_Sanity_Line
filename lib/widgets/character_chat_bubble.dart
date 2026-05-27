import 'package:flutter/material.dart';

// ─── Data model ───────────────────────────────────────────────────────────────

/// A single step in a character chat flow.
/// Each step has its own character asset + message text.
class ChatStep {
  final String imagePath;
  final String text;
  const ChatStep({required this.imagePath, required this.text});
}

// ─── CharacterChatBubble ──────────────────────────────────────────────────────
//
// A horizontal card overlay that slides up from the bottom:
//
//   ┌──────────────────────────────────────┐
//   │  [Character]  │  NAME                │
//   │    image      │  Message text…       │
//   │               │                      │
//   │               │  ●○○  [Next →]       │
//   └──────────────────────────────────────┘
//
// The character image changes per step. Use [CharacterChatBubble.show] to
// display it as an overlay without touching the route stack.

class CharacterChatBubble extends StatefulWidget {
  final String characterName;
  final List<ChatStep> steps;
  final Color accentColor;
  final VoidCallback? onDismiss;

  const CharacterChatBubble({
    super.key,
    required this.characterName,
    required this.steps,
    this.accentColor = const Color(0xFF1C5F5F),
    this.onDismiss,
  });

  // ── Static helper ─────────────────────────────────────────────────────────

  static void show({
    required BuildContext context,
    required String characterName,
    required List<ChatStep> steps,
    Color accentColor = const Color(0xFF1C5F5F),
    VoidCallback? onDismiss,
  }) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => CharacterChatBubble(
        characterName: characterName,
        steps: steps,
        accentColor: accentColor,
        onDismiss: () {
          entry.remove();
          onDismiss?.call();
        },
      ),
    );
    Overlay.of(context).insert(entry);
  }

  @override
  State<CharacterChatBubble> createState() => _CharacterChatBubbleState();
}

class _CharacterChatBubbleState extends State<CharacterChatBubble>
    with TickerProviderStateMixin {
  // ── Controllers ────────────────────────────────────────────────────────────
  late AnimationController _slideCtrl;
  late AnimationController _fadeCtrl;
  late AnimationController _contentCtrl;
  late AnimationController _floatCtrl;

  late Animation<Offset> _slideAnim;
  late Animation<double> _backdropFade;
  late Animation<double> _contentFade;
  late Animation<double> _floatAnim;

  int _step = 0;
  bool _dismissing = false;

  // Colour palette (matching assessment screen)
  static const _teal900 = Color(0xFF0d3d3d);
  static const _teal700 = Color(0xFF1a5f5f);
  static const _teal300 = Color(0xFF4aabab);
  static const _bg = Color(0xFFf7fafa);

  @override
  void initState() {
    super.initState();

    // Slide-up for the whole card
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));

    // Backdrop dim fade
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _backdropFade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    // Content (image + text) fade for step transitions
    _contentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _contentFade = CurvedAnimation(parent: _contentCtrl, curve: Curves.easeInOut);

    // Gentle vertical float loop
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: 0, end: -7).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // Staggered entry
    _fadeCtrl.forward();
    Future.delayed(const Duration(milliseconds: 60), () {
      if (mounted) {
        _slideCtrl.forward().then((_) {
          if (mounted) _contentCtrl.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    _fadeCtrl.dispose();
    _contentCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  // ── Dismiss ────────────────────────────────────────────────────────────────

  Future<void> _dismiss() async {
    if (_dismissing) return;
    _dismissing = true;
    await _contentCtrl.reverse();
    await _slideCtrl.reverse();
    await _fadeCtrl.reverse();
    widget.onDismiss?.call();
  }

  // ── Next step ──────────────────────────────────────────────────────────────

  void _next() async {
    if (_step < widget.steps.length - 1) {
      // Fade content out, swap, fade back in
      await _contentCtrl.reverse();
      if (mounted) {
        setState(() => _step++);
        _contentCtrl.forward();
      }
    } else {
      _dismiss();
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[_step];
    final isLast = _step == widget.steps.length - 1;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // ── Backdrop ───────────────────────────────────────────────────────
          FadeTransition(
            opacity: _backdropFade,
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(
                color: Colors.black.withValues(alpha: 0.45),
              ),
            ),
          ),

          // ── Card ───────────────────────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _slideAnim,
              child: _buildCard(currentStep, isLast),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ChatStep currentStep, bool isLast) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: _teal900.withValues(alpha: 0.20),
            blurRadius: 40,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 0),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: _teal300.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // ── Horizontal content row ────────────────────────────────────────
          FadeTransition(
            opacity: _contentFade,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Left: Character image panel ─────────────────────────
                  _buildCharacterPanel(currentStep.imagePath),

                  // ── Divider ────────────────────────────────────────────
                  Container(
                    width: 1,
                    color: _teal300.withValues(alpha: 0.18),
                  ),

                  // ── Right: Text panel ───────────────────────────────────
                  Expanded(
                    child: _buildTextPanel(currentStep.text, isLast),
                  ),
                ],
              ),
            ),
          ),

          // Safe area bottom padding
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Character image panel ──────────────────────────────────────────────────

  Widget _buildCharacterPanel(String imagePath) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _teal900,
            _teal700,
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Subtle radial glow behind character
          Positioned(
            bottom: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _teal300.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Character image with float animation
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedBuilder(
              animation: _floatAnim,
              builder: (ctx, child) => Transform.translate(
                offset: Offset(0, _floatAnim.value),
                child: child,
              ),
              child: Image.asset(
                imagePath,
                height: 175,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Text panel ─────────────────────────────────────────────────────────────

  Widget _buildTextPanel(String text, bool isLast) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name badge
          _buildNameBadge(),
          const SizedBox(height: 14),

          // Message
          Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.65,
              color: Color(0xFF1A3A3A),
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 20),

          // Bottom row: dots + button
          Row(
            children: [
              // Step dots
              if (widget.steps.length > 1) ...[
                ...List.generate(
                  widget.steps.length,
                  (i) => _StepDot(active: i == _step, color: _teal900),
                ),
              ],
              const Spacer(),
              _CTAButton(
                isLast: isLast,
                accentColor: widget.accentColor,
                onTap: _next,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameBadge() {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: _teal300,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          widget.characterName,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
            color: _teal700,
          ),
        ),
        const SizedBox(width: 8),
        _TypingIndicator(),
      ],
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  static const _teal500 = Color(0xFF2a8a8a);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) {
        return Row(
          children: List.generate(3, (i) {
            final phase = ((_ctrl.value * 3) - i).clamp(0.0, 1.0);
            final opacity = (phase < 0.5 ? phase : 1.0 - phase) * 2;
            return Container(
              margin: const EdgeInsets.only(right: 3),
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: _teal500.withValues(alpha: opacity.clamp(0.15, 1.0)),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool active;
  final Color color;
  const _StepDot({required this.active, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      width: active ? 22 : 6,
      height: 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: active ? color : color.withValues(alpha: 0.20),
      ),
    );
  }
}

class _CTAButton extends StatelessWidget {
  final bool isLast;
  final Color accentColor;
  final VoidCallback onTap;

  const _CTAButton({
    required this.isLast,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: isLast ? accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: accentColor, width: 1.5),
          boxShadow: isLast
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLast ? 'Got it!' : 'Next',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isLast ? Colors.white : accentColor,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              isLast ? Icons.check_rounded : Icons.arrow_forward_rounded,
              size: 15,
              color: isLast ? Colors.white : accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
