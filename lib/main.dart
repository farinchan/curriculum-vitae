import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Modern color palette
  static const Color primaryDark = Color(0xFF1A1A2E);
  static const Color primaryBlue = Color(0xFF4A90A4);
  static const Color accentGold = Color(0xFFD4A574);
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fajri Rinaldi Chan - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: bgLight,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: accentGold,
          tertiary: primaryDark,
          surface: bgCard,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: textDark,
        ),
        textTheme: TextTheme(
          // Hero text
          displayLarge: GoogleFonts.plusJakartaSans(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: primaryDark,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          // Section titles
          displayMedium: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: primaryDark,
            letterSpacing: -0.5,
          ),
          // Card titles
          displaySmall: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w600, color: primaryDark),
          // Subtitles
          headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w600, color: textDark),
          // Body title
          titleMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: textDark),
          // Body text
          bodyLarge: GoogleFonts.inter(fontSize: 15, height: 1.6, color: textMuted),
          bodyMedium: GoogleFonts.inter(fontSize: 14, height: 1.5, color: textMuted),
          bodySmall: GoogleFonts.inter(fontSize: 13, height: 1.4, color: textMuted),
          // Labels
          labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textMuted,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: borderLight, width: 1),
          ),
          color: bgCard,
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlue,
            side: const BorderSide(color: primaryBlue, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        dividerTheme: const DividerThemeData(color: borderLight, thickness: 1),
        iconTheme: const IconThemeData(color: primaryBlue, size: 20),
      ),
      home: const HomePage(),
    );
  }
}
