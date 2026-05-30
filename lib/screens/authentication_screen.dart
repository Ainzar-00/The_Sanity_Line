import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../animations/smoke_painter.dart';
import '../authentication/auth_service.dart';
import '../widgets/google_logo.dart';

// ── LoginScreen ───────────────────────────────────────────────────────────────
// Pure UI — all auth logic is delegated to AuthService.

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  // ── Controllers ─────────────────────────────────────────────────────────────
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  // ── State ────────────────────────────────────────────────────────────────────
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isLoginMode = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _smokeController;

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _smokeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _smokeController.dispose();
    super.dispose();
  }

  // ── Auth callbacks (thin wrappers around AuthService) ────────────────────────

  Future<void> _handleAuth() async {
    setState(() => _isLoading = true);

    final result = _isLoginMode
        ? await AuthService.login(
            _emailController.text,
            _passwordController.text,
            ref: ref,
          )
        : await AuthService.signUp(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _confirmPasswordController.text,
            ref: ref,
          );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result.success) {
      Navigator.pushReplacementNamed(
        context,
        result.route!,
        arguments: result.routeArguments,
      );
    } else if (result.errorMessage!.isNotEmpty) {
      _showSnackBar(result.errorMessage!);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);

    final result = await AuthService.signInWithGoogle(isLogin: _isLoginMode, ref: ref);

    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    if (result.success) {
      Navigator.pushReplacementNamed(
        context,
        result.route!,
        arguments: result.routeArguments,
      );
    } else if (result.errorMessage!.isNotEmpty) {
      _showSnackBar(result.errorMessage!);
    }
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _nameController.clear();
      _obscurePassword = true;
      _obscureConfirmPassword = true;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C5F5F),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EE),
      body: Stack(
        children: [
          // Smoke background animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _smokeController,
              builder: (context, _) => CustomPaint(
                painter: SmokePainter(time: _smokeController.value),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        _isLoginMode ? 'Welcome Back' : 'Create Account',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1C5F5F),
                          fontFamily: 'Georgia',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Full Name — sign-up only
                    if (!_isLoginMode) ...[
                      _fieldLabel('Full Name'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _nameController,
                        hint: 'Full Name',
                      ),
                      const SizedBox(height: 20),
                    ],

                    _fieldLabel('Email Address'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _fieldLabel('Password'),
                        if (_isLoginMode)
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF888888),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      obscure: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF1C5F5F),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),

                    // Confirm Password — sign-up only
                    if (!_isLoginMode) ...[
                      const SizedBox(height: 20),
                      _fieldLabel('Confirm Password'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        hint: 'Confirm Password',
                        obscure: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF1C5F5F),
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Primary action button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C5F5F),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isLoginMode ? 'Sign In' : 'Create Account',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Divider
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFFCCCCCC))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFFCCCCCC))),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Google sign-in button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed:
                            _isGoogleLoading ? null : _handleGoogleSignIn,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDDDDDD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: _isGoogleLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Color(0xFF1C5F5F),
                                  strokeWidth: 2,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GoogleLogo(),
                                  SizedBox(width: 10),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Toggle login / sign-up
                    Center(
                      child: GestureDetector(
                        onTap: _toggleMode,
                        child: Text(
                          _isLoginMode ? 'Create Account' : 'Sign In Instead',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1C5F5F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Private UI helpers ────────────────────────────────────────────────────────

  Widget _fieldLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1C5F5F),
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFF1C5F5F), width: 1.5),
        ),
      ),
    );
  }
}
