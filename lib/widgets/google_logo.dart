import 'package:flutter/material.dart';

// ── Google Logo ───────────────────────────────────────────────────────────────

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/google_img.png',
        width: 22,
        height: 22,
      );
}
