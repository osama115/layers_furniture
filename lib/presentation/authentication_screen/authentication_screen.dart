import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../onboarding_screen/widgets/hexagonal_logo_widget.dart';
import './widgets/authentication_buttons_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _buttonsAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    ));

    _buttonsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    // TODO: Navigate to login screen
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  void _onRegisterPressed() {
    // TODO: Navigate to register screen
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  void _onContinueAsGuestPressed() {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&h=1200&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark gradient overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(77),
                  Colors.black.withAlpha(153),
                  Colors.black.withAlpha(204),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  // Logo and brand name
                  AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _logoAnimation,
                        child: Transform.scale(
                          scale: _logoAnimation.value,
                          child: Column(
                            children: [
                              const HexagonalLogoWidget(
                                size: 120,
                                color: Color(0xFF2D5A3D),
                                textColor: Colors.white,
                                text: '7',
                              ),
                              const SizedBox(height: 24),
                              AnimatedBuilder(
                                animation: _textAnimation,
                                builder: (context, child) {
                                  return FadeTransition(
                                    opacity: _textAnimation,
                                    child: Transform.translate(
                                      offset: Offset(
                                          0, 20 * (1 - _textAnimation.value)),
                                      child: Text(
                                        'LAYERS',
                                        style: GoogleFonts.inter(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 4.0,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(flex: 3),
                  // Authentication buttons
                  AnimatedBuilder(
                    animation: _buttonsAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _buttonsAnimation,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - _buttonsAnimation.value)),
                          child: AuthenticationButtonsWidget(
                            onLoginPressed: _onLoginPressed,
                            onRegisterPressed: _onRegisterPressed,
                            onContinueAsGuestPressed: _onContinueAsGuestPressed,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
