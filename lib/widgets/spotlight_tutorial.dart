import 'package:flutter/material.dart';

class TutorialStep {
  final GlobalKey? targetKey;
  final String text;
  final String imagePath;
  final Future<void> Function()? onStart;
  final Future<void> Function()? onComplete;

  TutorialStep({
    this.targetKey,
    required this.text,
    required this.imagePath,
    this.onStart,
    this.onComplete,
  });
}

class SpotlightTutorial {
  static void show(BuildContext context, List<TutorialStep> steps) {
    if (steps.isEmpty) return;
    
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    int currentStep = 0;

    void removeOverlay() {
      overlayEntry?.remove();
      overlayEntry = null;
    }

    void buildStep() async {
      final step = steps[currentStep];
      if (step.onStart != null) {
        await step.onStart!();
        // Give time for UI to build and animations to settle
        await Future.delayed(const Duration(milliseconds: 400));
      }

      overlayEntry?.markNeedsBuild();
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        final step = steps[currentStep];
        Rect? targetRect;
        
        if (step.targetKey != null && step.targetKey!.currentContext != null) {
          final renderBox = step.targetKey!.currentContext!.findRenderObject() as RenderBox?;
          if (renderBox != null && renderBox.hasSize) {
            final position = renderBox.localToGlobal(Offset.zero);
            targetRect = position & renderBox.size;
          }
        }

        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Dark background with cutout
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _SpotlightPainter(targetRect),
              ),
              // Invisible tap layer to prevent tapping underneath
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {}, // Blocks taps
                  child: Container(color: Colors.transparent),
                ),
              ),
              // The tutorial bubble
              _buildTutorialBubble(
                context: context,
                step: step,
                targetRect: targetRect,
                onNext: () async {
                  if (step.onComplete != null) {
                    await step.onComplete!();
                  }
                  
                  if (currentStep < steps.length - 1) {
                    currentStep++;
                    buildStep();
                  } else {
                    removeOverlay();
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    overlayState.insert(overlayEntry!);
    buildStep();
  }

  static Widget _buildTutorialBubble({
    required BuildContext context,
    required TutorialStep step,
    required Rect? targetRect,
    required VoidCallback onNext,
  }) {
    final screenSize = MediaQuery.of(context).size;
    
    double? top;
    double? bottom;
    double left = 24;
    double right = 24;

    if (targetRect == null) {
      // Centered on screen
      left = 0;
      right = 0;
    } else {
      double spaceAtBottom = screenSize.height - targetRect.bottom;
      double spaceAtTop = targetRect.top;

      if (spaceAtBottom < 300) {
        if (spaceAtTop >= 300) {
          // Place above the target
          bottom = screenSize.height - targetRect.top + 20;
        } else {
          // Target is too tall or in the middle. Place at fixed bottom position
          // This keeps dialogs like Meal Details from overlapping the top
          bottom = 80;
        }
      } else {
        // Place below the target
        top = targetRect.bottom + 20;
      }
    }

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    step.imagePath,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DR. LINDA',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C8C6A),
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          step.text,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1C5F5F),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C8C6A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Rect? targetRect;

  _SpotlightPainter(this.targetRect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    if (targetRect == null) {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      return;
    }

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Punch the hole
    final cutoutPaint = Paint()..blendMode = BlendMode.clear;
    
    // Add padding to rect
    final expandedRect = targetRect!.inflate(8.0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(expandedRect, const Radius.circular(16)),
      cutoutPaint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect;
  }
}
