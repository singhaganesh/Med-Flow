import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette (MediFlow)
  static const Color primary = Color(0xFF0077B6);      // MediBlue
  static const Color secondary = Color(0xFF06B6D4);    // HealthTeal
  static const Color background = Color(0xFFF8FAFC);   // CleanSlate
  static const Color foreground = Color(0xFF0F172A);   // Deep Slate (Text/Inverted BG)
  static const Color textMain = Color(0xFF1E293B);     // DeepCharcoal
  static const Color muted = Color(0xFFF1F5F9);        // Slate-100
  static const Color mutedForeground = Color(0xFF64748B); // Slate-500
  static const Color accent = Color(0xFFFB923C);       // VitalOrange
  
  // Signature Gradient (Electric Blue from Theme + MediFlow mix)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF4D7CFF)],
  );

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Surfaces
  static const Color card = Colors.white;
  static const Color border = Color(0xFFE2E8F0);       // Slate-200
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
