import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import './widgets/hexagonal_logo_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _parallaxController;

  late Animation<double> _logoAnimation;
  late Animation<double> _brandNameAnimation;
  late Animation<double> _taglineAnimation;
  late Animation<double> _parallaxAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _parallaxController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    // Create animations
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _brandNameAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
    ));

    _taglineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    _parallaxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _parallaxController,
      curve: Curves.linear,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });

    _parallaxController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: _navigateToHome,
        child: Stack(
          children: [
            // Background image with parallax effect
            AnimatedBuilder(
              animation: _parallaxAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_parallaxAnimation.value * 20),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight + 40,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=1200&auto=format&fit=crop',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFFF5F5F5),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2D5A3D),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFFF5F5F5),
                        child: const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Color(0xFF2D5A3D),
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(77),
                    Colors.black.withAlpha(179),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Logo and brand name section
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Hexagonal logo with animation
                          AnimatedBuilder(
                            animation: _logoAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _logoAnimation.value,
                                child: Opacity(
                                  opacity: _logoAnimation.value,
                                  child: const HexagonalLogoWidget(
                                    size: 120,
                                    color: Color(0xFF2D5A3D),
                                    textColor: Colors.white,
                                    text: '7',
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          // Brand name with animation
                          AnimatedBuilder(
                            animation: _brandNameAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                    0, (1 - _brandNameAnimation.value) * 30),
                                child: Opacity(
                                  opacity: _brandNameAnimation.value,
                                  child: Text(
                                    'LAYERS',
                                    style: GoogleFonts.inter(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 8.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Tagline section
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedBuilder(
                            animation: _taglineAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                    0, (1 - _taglineAnimation.value) * 20),
                                child: Opacity(
                                  opacity: _taglineAnimation.value,
                                  child: Text(
                                    'Find the best home furniture for you rooms.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 48),

                          // Tap to continue hint
                          AnimatedBuilder(
                            animation: _taglineAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _taglineAnimation.value * 0.7,
                                child: Text(
                                  'Tap anywhere to continue',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withAlpha(204),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
