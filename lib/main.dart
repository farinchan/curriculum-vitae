import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2C3E50),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB), // Slightly warmer/cleaner white-grey
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2C3E50),
          secondary: Color(0xFFE67E22), // More vibrant orange
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF2C3E50),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2C3E50),
            letterSpacing: -0.5,
          ),
          displayMedium: GoogleFonts.montserrat(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C3E50),
          ),
          displaySmall: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C3E50),
          ),
          headlineMedium: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF34495E),
          ),
          titleMedium: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF2C3E50)),
          bodyLarge: GoogleFonts.openSans(fontSize: 16, height: 1.5, color: const Color(0xFF485460)),
          bodyMedium: GoogleFonts.openSans(fontSize: 14, height: 1.5, color: const Color(0xFF57606F)),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly more rounded
            side: const BorderSide(color: Color(0xFFEDF2F7), width: 1.5), // Softer, thicker border
          ),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C3E50),
            foregroundColor: Colors.white,
            elevation: 0, // Flat
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
        ),
        dividerTheme: const DividerThemeData(color: Color(0xFFBDC3C7), thickness: 1),
      ),
      home: const HomePage(),
    );
  }
}
