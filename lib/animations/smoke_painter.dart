import 'package:flutter/material.dart';
import 'dart:math' as math;

// ── Strand configuration ──────────────────────────────────────────────────────

class StrandConfig {
  final double phase, freq, amp, yScale, speed, alpha, width;
  final bool isTR;
  const StrandConfig({
    required this.phase,
    required this.freq,
    required this.amp,
    required this.yScale,
    required this.speed,
    required this.alpha,
    required this.width,
    required this.isTR,
  });
}

// ── Full-screen smoke painter ─────────────────────────────────────────────────
// TR strands: mid-top (W/2, 0) → mid-right (W, H/2)
// BL strands: mid-left (0, H/2) → mid-bottom (W/2, H)

class SmokePainter extends CustomPainter {
  final double time;
  static const _color = Color(0xFF1C5F5F);

  static const _strands = [
    StrandConfig(phase: 0.00, freq: 1.2, amp: 72, yScale: 0.90, speed: 0.45, alpha: 0.22, width: 1.4, isTR: true),
    StrandConfig(phase: 0.14, freq: 0.8, amp: 88, yScale: 0.75, speed: 0.32, alpha: 0.16, width: 1.0, isTR: true),
    StrandConfig(phase: 0.28, freq: 1.6, amp: 55, yScale: 0.95, speed: 0.58, alpha: 0.19, width: 1.6, isTR: true),
    StrandConfig(phase: 0.42, freq: 0.6, amp: 95, yScale: 0.65, speed: 0.40, alpha: 0.13, width: 0.9, isTR: true),
    StrandConfig(phase: 0.35, freq: 1.4, amp: 78, yScale: 0.88, speed: 0.50, alpha: 0.18, width: 1.3, isTR: true),
    StrandConfig(phase: 0.18, freq: 0.7, amp: 92, yScale: 0.68, speed: 0.36, alpha: 0.14, width: 1.1, isTR: true),
    StrandConfig(phase: 0.78, freq: 1.5, amp: 65, yScale: 0.85, speed: 0.48, alpha: 0.15, width: 1.2, isTR: true),
    StrandConfig(phase: 0.54, freq: 1.1, amp: 82, yScale: 0.92, speed: 0.55, alpha: 0.17, width: 1.4, isTR: true),
    StrandConfig(phase: 0.57, freq: 1.9, amp: 62, yScale: 0.85, speed: 0.65, alpha: 0.17, width: 1.2, isTR: false),
    StrandConfig(phase: 0.71, freq: 1.1, amp: 80, yScale: 0.70, speed: 0.28, alpha: 0.12, width: 1.5, isTR: false),
    StrandConfig(phase: 0.85, freq: 0.9, amp: 68, yScale: 0.80, speed: 0.52, alpha: 0.15, width: 1.1, isTR: false),
    StrandConfig(phase: 0.92, freq: 1.3, amp: 85, yScale: 0.82, speed: 0.42, alpha: 0.14, width: 1.4, isTR: false),
    StrandConfig(phase: 0.48, freq: 1.7, amp: 60, yScale: 0.90, speed: 0.60, alpha: 0.16, width: 1.5, isTR: false),
    StrandConfig(phase: 0.22, freq: 1.4, amp: 75, yScale: 0.88, speed: 0.38, alpha: 0.13, width: 1.3, isTR: false),
    StrandConfig(phase: 0.64, freq: 0.8, amp: 88, yScale: 0.76, speed: 0.45, alpha: 0.16, width: 1.0, isTR: false),
    StrandConfig(phase: 0.33, freq: 1.6, amp: 58, yScale: 0.94, speed: 0.55, alpha: 0.18, width: 1.2, isTR: false),
  ];

  const SmokePainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in _strands) {
      _drawStrand(canvas, size, s);
    }
  }

  void _drawStrand(Canvas canvas, Size size, StrandConfig s) {
    final W = size.width;
    final H = size.height;
    final double t = time * s.speed + s.phase;

    const numPoints = 60;
    final pts = <Offset>[];

    for (int i = 0; i <= numPoints; i++) {
      final frac = i / numPoints;
      final eased = frac * frac * (3.0 - 2.0 * frac);

      final wave1 = math.sin(frac * math.pi * s.freq * 2.0 + t * math.pi * 0.5);
      final wave2 = math.cos(
        frac * math.pi * s.freq * 1.5 + t * math.pi * 0.4 + s.phase * math.pi,
      );
      final wave3 = math.sin(
        frac * math.pi * s.freq * 0.9 + t * math.pi * 0.7 + s.phase * 4.0,
      );

      final sineEnv = math.sin(frac * math.pi);
      final envelope = sineEnv * sineEnv;
      final lx = (wave1 * s.amp * 0.9 + wave3 * s.amp * 0.35) * envelope;
      final ly = (wave2 * s.amp * 0.75 + wave3 * s.amp * 0.25) * envelope;

      final double x, y;
      if (s.isTR) {
        x = W * 0.25 + (W * 0.75) * eased + lx;
        y = 0 + (H * 0.25) * eased + ly;
      } else {
        x = 0 + (W * 1.0) * eased + lx;
        y = H * 0.25 + (H * 0.75) * eased + ly;
      }
      pts.add(Offset(x, y));
    }

    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i == 0 ? 0 : i - 1];
      final p1 = pts[i];
      final p2 = pts[i + 1];
      final p3 = pts[i + 1 < pts.length - 1 ? i + 2 : i + 1];
      path.cubicTo(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
        p2.dx,
        p2.dy,
      );
    }

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final targetWidth = s.isTR ? s.width : s.width * 0.45;

    canvas.drawPath(
      path,
      base
        ..strokeWidth = targetWidth
        ..color = _color.withValues(alpha: s.alpha),
    );

    canvas.drawPath(
      path,
      base
        ..strokeWidth = targetWidth * 2.8
        ..color = _color.withValues(alpha: s.alpha * 0.18),
    );
  }

  @override
  bool shouldRepaint(SmokePainter old) => old.time != time;
}
