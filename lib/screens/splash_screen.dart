import 'package:flutter/material.dart';
import '../authentication/auth_service.dart';

// ── SplashScreen ──────────────────────────────────────────────────────────────
// Pure UI — session check is delegated to AuthService.checkCurrentUser().

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final result = await AuthService.checkCurrentUser();
    if (!mounted) return;
    if (result == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(
        context,
        result.route!,
        arguments: result.routeArguments,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.80,
                height: size.height * 0.30,
                child: Image.asset(
                  'assets/Logo_de_boussole_celtique-removebg-preview.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
