import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Theme constants for consistent styling across the application
class AppTheme {
  // Colors inspired by the travel/booking app UI design
  static const Color primaryColor = Color(0xFFFF7366); // Salmon Red
  static const Color secondaryColor = Color(0xFF3498DB); // Sky Blue
  static const Color accentColor = Color(0xFF2C3E50); // Deep Blue
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF2D3142);
  static const Color textLight = Color(0xFF9C9EB9);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFFFF9D92)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, Color(0xFF45AAE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
  
  // Button styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
  
  // Text styles
  static TextStyle get headingStyle => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  
  static TextStyle get subheadingStyle => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
  );
  
  static TextStyle get bodyStyle => GoogleFonts.poppins(
    fontSize: 16,
    color: textDark,
    height: 1.5,
  );
  
  static TextStyle get captionStyle => GoogleFonts.poppins(
    fontSize: 14,
    color: textLight,
  );
  
  // Create theme data to be used in MaterialApp
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: Colors.white,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      // Custom theme settings
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
} 