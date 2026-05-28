import 'package:flutter/material.dart';
import '../models/morning_checkin_model.dart';

// ── MorningCheckinDialog ──────────────────────────────────────────────────────
//
// A Professor-led multi-step morning check-in overlay.
// Rendered as a slide-up bottom sheet in the same style as CharacterChatBubble.
//
// Usage:
//   MorningCheckinDialog.show(
//     context: context,
//     userId: uid,
//     onComplete: (checkin) async { ... },
//   );

// ── Colour tokens (matching assessment screen) ─────────────────────────────────
const _teal900 = Color(0xFF0d3d3d);
const _teal700 = Color(0xFF1a5f5f);
const _teal500 = Color(0xFF2a8a8a);
const _teal300 = Color(0xFF4aabab);
const _bg = Color(0xFFf7fafa);

// ── Step definitions ──────────────────────────────────────────────────────────

enum _CheckinStep {
  greeting,
  mood,
  energy,
  digestion,
  bloating,
  stoolForm,
  notes,
  done,
}

class MorningCheckinDialog extends StatefulWidget {
  final String userId;
  final Future<void> Function(MorningCheckinModel) onComplete;

  const MorningCheckinDialog({
    super.key,
    required this.userId,
    required this.onComplete,
  });

  // ── Static helper ──────────────────────────────────────────────────────────

  static void show({
    required BuildContext context,
    required String userId,
    required Future<void> Function(MorningCheckinModel) onComplete,
  }) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => MorningCheckinDialog(
        userId: userId,
        onComplete: (checkin) async {
          entry.remove();
          await onComplete(checkin);
        },
      ),
    );
    Overlay.of(context).insert(entry);
  }

  @override
  State<MorningCheckinDialog> createState() => _MorningCheckinDialogState();
}

class _MorningCheckinDialogState extends State<MorningCheckinDialog>
    with TickerProviderStateMixin {
  // ── Animation controllers ──────────────────────────────────────────────────
  late AnimationController _slideCtrl;
  late AnimationController _fadeCtrl;
  late AnimationController _contentCtrl;
  late AnimationController _floatCtrl;

  late Animation<Offset> _slideAnim;
  late Animation<double> _backdropFade;
  late Animation<double> _contentFade;
  late Animation<double> _floatAnim;

  // ── State ──────────────────────────────────────────────────────────────────
  _CheckinStep _step = _CheckinStep.greeting;
  bool _dismissing = false;
  bool _submitting = false;

  // Collected answers
  int? _mood;
  int? _energy;
  int? _digestion;
  int? _bloating;
  int? _stoolForm;
  final _notesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _slideCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 480));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _backdropFade =
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    _contentCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260));
    _contentFade =
        CurvedAnimation(parent: _contentCtrl, curve: Curves.easeInOut);

    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600))
      ..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: 0, end: -7).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

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
    _notesCtrl.dispose();
    super.dispose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  Future<void> _advance() async {
    await _contentCtrl.reverse();
    if (!mounted) return;
    setState(() {
      _step = _CheckinStep.values[_step.index + 1];
    });
    _contentCtrl.forward();

    // Auto-submit when reaching done
    if (_step == _CheckinStep.done) {
      _submit();
    }
  }

  Future<void> _dismiss() async {
    if (_dismissing) return;
    _dismissing = true;
    await _contentCtrl.reverse();
    await _slideCtrl.reverse();
    await _fadeCtrl.reverse();
    // Call onComplete with whatever we have so far (partial is fine)
    widget.onComplete(
      MorningCheckinModel(
        userId: widget.userId,
        date: DateTime.now(),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final checkin = MorningCheckinModel(
      userId: widget.userId,
      date: DateTime.now(),
      mood: _mood,
      energy: _energy,
      digestionQuality: _digestion,
      bloating: _bloating,
      stoolFormBss: _stoolForm,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
    );
    await widget.onComplete(checkin);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Backdrop
          FadeTransition(
            opacity: _backdropFade,
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),
          // Card
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _slideAnim,
              child: _buildCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
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
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: _teal300.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          FadeTransition(
            opacity: _contentFade,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCharacterPanel(),
                  Container(width: 1, color: _teal300.withValues(alpha: 0.18)),
                  Expanded(child: _buildContentPanel()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Character image panel ──────────────────────────────────────────────────

  Widget _buildCharacterPanel() {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_teal900, _teal700],
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  _teal300.withValues(alpha: 0.22),
                  Colors.transparent
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedBuilder(
              animation: _floatAnim,
              builder: (ctx, child) => Transform.translate(
                offset: Offset(0, _floatAnim.value),
                child: child,
              ),
              child: Image.asset(
                _stepImage(),
                height: 175,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _stepImage() {
    switch (_step) {
      case _CheckinStep.greeting:
        return 'assets/chatPersonas/professorWaving.png';
      case _CheckinStep.done:
        return 'assets/chatPersonas/professorWaving.png';
      default:
        return 'assets/chatPersonas/professorExplaining.png';
    }
  }

  // ── Content panel ──────────────────────────────────────────────────────────

  Widget _buildContentPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameBadge(),
          const SizedBox(height: 14),
          _buildStepContent(),
        ],
      ),
    );
  }

  Widget _buildNameBadge() {
    return Row(
      children: [
        Container(
          width: 7, height: 7,
          decoration: const BoxDecoration(color: _teal300, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        const Text(
          'THE PROFESSOR',
          style: TextStyle(
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

  Widget _buildStepContent() {
    switch (_step) {
      case _CheckinStep.greeting:
        return _buildGreeting();
      case _CheckinStep.mood:
        return _buildScale(
          question: "How's your mood this morning?",
          value: _mood,
          labels: const ['Very low', 'Low', 'Neutral', 'Good', 'Excellent'],
          onSelect: (v) => setState(() => _mood = v),
          onNext: _advance,
        );
      case _CheckinStep.energy:
        return _buildScale(
          question: "How's your energy level?",
          value: _energy,
          labels: const ['Exhausted', 'Tired', 'Okay', 'Good', 'Energised'],
          onSelect: (v) => setState(() => _energy = v),
          onNext: _advance,
        );
      case _CheckinStep.digestion:
        return _buildScale(
          question: "How is your digestion feeling?",
          value: _digestion,
          labels: const ['Very poor', 'Poor', 'Okay', 'Good', 'Great'],
          onSelect: (v) => setState(() => _digestion = v),
          onNext: _advance,
        );
      case _CheckinStep.bloating:
        return _buildScale(
          question: "Any bloating this morning?",
          value: _bloating,
          labels: const ['None', 'Mild', 'Moderate', 'Strong', 'Severe'],
          onSelect: (v) => setState(() => _bloating = v),
          onNext: _advance,
        );
      case _CheckinStep.stoolForm:
        return _buildBristolScale();
      case _CheckinStep.notes:
        return _buildNotes();
      case _CheckinStep.done:
        return _buildDone();
    }
  }

  // ── Step: Greeting ─────────────────────────────────────────────────────────

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$greeting! 🌅 Before you start your day, let's do a quick gut & wellbeing check-in. It only takes a minute.",
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.65,
            color: Color(0xFF1A3A3A),
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 20),
        _CTAButton(label: "Let's go!", isLast: false, onTap: _advance),
      ],
    );
  }

  // ── Step: Generic 1–5 scale ────────────────────────────────────────────────

  Widget _buildScale({
    required String question,
    required int? value,
    required List<String> labels,
    required void Function(int) onSelect,
    required VoidCallback onNext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: Color(0xFF1A3A3A),
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (i) {
            final v = i + 1;
            final selected = value == v;
            return GestureDetector(
              onTap: () => onSelect(v),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? _teal500 : _teal300.withValues(alpha: 0.15),
                  border: Border.all(
                    color: selected ? _teal500 : _teal300.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: _teal500.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    '$v',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : _teal700,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(labels[0],
                style: const TextStyle(fontSize: 9, color: Color(0xFF7aabab))),
            Text(labels[4],
                style: const TextStyle(fontSize: 9, color: Color(0xFF7aabab))),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Spacer(),
            _CTAButton(
              label: 'Next',
              isLast: false,
              onTap: value != null ? onNext : null,
            ),
          ],
        ),
      ],
    );
  }

  // ── Step: Bristol Stool Scale (1–7) ───────────────────────────────────────

  Widget _buildBristolScale() {
    const types = [
      (num: 1, label: 'Hard lumps'),
      (num: 2, label: 'Lumpy sausage'),
      (num: 3, label: 'Cracked sausage'),
      (num: 4, label: 'Smooth sausage'),
      (num: 5, label: 'Soft blobs'),
      (num: 6, label: 'Fluffy pieces'),
      (num: 7, label: 'Watery'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Stool form today? (Bristol scale)',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: Color(0xFF1A3A3A),
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '4 = ideal  ·  1–2 = constipation  ·  6–7 = loose',
          style: TextStyle(fontSize: 9.5, color: Color(0xFF7aabab)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types.map((t) {
            final selected = _stoolForm == t.num;
            // Colour coding: 3-4-5 = ideal green, 1-2 = amber, 6-7 = orange
            Color accent;
            if (t.num >= 3 && t.num <= 5) {
              accent = const Color(0xFF4CAF50);
            } else if (t.num <= 2) {
              accent = const Color(0xFFFF9800);
            } else {
              accent = const Color(0xFFFF7043);
            }
            return GestureDetector(
              onTap: () => setState(() => _stoolForm = t.num),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: selected ? accent : accent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? accent : accent.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '${t.num}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : accent,
                      ),
                    ),
                    Text(
                      t.label,
                      style: TextStyle(
                        fontSize: 8.5,
                        color: selected ? Colors.white70 : accent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            TextButton(
              onPressed: _advance,
              child: const Text('Skip',
                  style: TextStyle(color: Color(0xFF7aabab), fontSize: 12)),
            ),
            const Spacer(),
            _CTAButton(
              label: 'Next',
              isLast: false,
              onTap: _stoolForm != null ? _advance : null,
            ),
          ],
        ),
      ],
    );
  }

  // ── Step: Notes ────────────────────────────────────────────────────────────

  Widget _buildNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Any notes or symptoms to add? (optional)',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: Color(0xFF1A3A3A),
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesCtrl,
          maxLines: 3,
          style: const TextStyle(fontSize: 13, color: _teal900),
          decoration: InputDecoration(
            hintText: 'e.g. stomach cramp after dinner last night...',
            hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF9ab8b8)),
            filled: true,
            fillColor: _teal300.withValues(alpha: 0.07),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _teal300.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _teal300.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _teal500, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Spacer(),
            _CTAButton(label: 'Submit ✓', isLast: true, onTap: _advance),
          ],
        ),
      ],
    );
  }

  // ── Step: Done ─────────────────────────────────────────────────────────────

  Widget _buildDone() {
    if (_submitting) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: CircularProgressIndicator(color: _teal500, strokeWidth: 2),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'All logged! Have a great day — I\'ll check in with you again tomorrow morning.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.65,
            color: Color(0xFF1A3A3A),
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            _CTAButton(label: 'Got it!', isLast: true, onTap: _dismiss),
          ],
        ),
      ],
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

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
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
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

class _CTAButton extends StatelessWidget {
  final String label;
  final bool isLast;
  final VoidCallback? onTap;

  const _CTAButton({
    required this.label,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: enabled
              ? (isLast ? _teal500 : Colors.transparent)
              : Colors.grey.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: enabled ? _teal500 : Colors.grey.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: (isLast && enabled)
              ? [
                  BoxShadow(
                    color: _teal500.withValues(alpha: 0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: enabled
                ? (isLast ? Colors.white : _teal500)
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
