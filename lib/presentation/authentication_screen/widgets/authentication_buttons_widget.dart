import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationButtonsWidget extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onContinueAsGuestPressed;

  const AuthenticationButtonsWidget({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onContinueAsGuestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Login button (primary)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5A3D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: Text(
              'Login',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Register button (secondary)
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onRegisterPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              'Register',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Continue as guest (tertiary)
        TextButton(
          onPressed: onContinueAsGuestPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Continue as a guest',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
