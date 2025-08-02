import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
/// Implements Empathetic Minimalism design with Nocturnal Comfort color palette
/// for anonymous confession and mental health support app.
class AppTheme {
  AppTheme._();

  // Nocturnal Comfort Color Palette
  static const Color primaryDark =
      Color(0xFF1A1A1A); // Deep charcoal background
  static const Color secondaryDark =
      Color(0xFF2D2D2D); // Elevated surface color
  static const Color accentPurple =
      Color(0xFF6B73FF); // Supportive purple for primary actions
  static const Color supportTeal =
      Color(0xFF4ECDC4); // Gentle teal for positive reactions
  static const Color warningAmber =
      Color(0xFFFFB74D); // Soft amber for content warnings
  static const Color errorRose = Color(0xFFF06292); // Muted rose for errors
  static const Color textPrimary =
      Color(0xFFE8E8E8); // High contrast white-gray
  static const Color textSecondary =
      Color(0xFFA0A0A0); // Medium gray for metadata
  static const Color textTertiary =
      Color(0xFF6A6A6A); // Subtle gray for timestamps
  static const Color surfaceOverlay =
      Color(0x1AFFFFFF); // Minimal white overlay

  // Additional semantic colors
  static const Color cardColor = Color(0xFF2D2D2D);
  static const Color dialogColor = Color(0xFF2D2D2D);
  static const Color dividerColor = Color(0x1AFFFFFF);
  static const Color shadowColor = Color(0x40000000);

  /// Dark theme (primary theme for nocturnal comfort)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentPurple,
      onPrimary: textPrimary,
      primaryContainer: accentPurple.withValues(alpha: 0.2),
      onPrimaryContainer: textPrimary,
      secondary: supportTeal,
      onSecondary: primaryDark,
      secondaryContainer: supportTeal.withValues(alpha: 0.2),
      onSecondaryContainer: textPrimary,
      tertiary: warningAmber,
      onTertiary: primaryDark,
      tertiaryContainer: warningAmber.withValues(alpha: 0.2),
      onTertiaryContainer: textPrimary,
      error: errorRose,
      onError: textPrimary,
      surface: primaryDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: dividerColor,
      outlineVariant: surfaceOverlay,
      shadow: shadowColor,
      scrim: shadowColor,
      inverseSurface: textPrimary,
      onInverseSurface: primaryDark,
      inversePrimary: accentPurple,
    ),
    scaffoldBackgroundColor: primaryDark,
    cardColor: cardColor,
    dividerColor: dividerColor,

    // AppBar theme for protective intimacy
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: textPrimary,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    ),

    // Card theme with subtle elevation
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2.0,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation for contextual actions
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryDark,
      selectedItemColor: accentPurple,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button for contextual actions
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentPurple,
      foregroundColor: textPrimary,
      elevation: 4.0,
      focusElevation: 6.0,
      hoverElevation: 6.0,
      highlightElevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Button themes for gentle interactions
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: textPrimary,
        backgroundColor: accentPurple,
        disabledForegroundColor: textTertiary,
        disabledBackgroundColor: textTertiary.withValues(alpha: 0.3),
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentPurple,
        disabledForegroundColor: textTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: accentPurple, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentPurple,
        disabledForegroundColor: textTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    // Typography for emotional comfort
    textTheme: _buildTextTheme(),

    // Input decoration for safe interactions
    inputDecorationTheme: InputDecorationTheme(
      fillColor: secondaryDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: surfaceOverlay),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: surfaceOverlay),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: accentPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorRose),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorRose, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textTertiary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Switch theme for gentle toggles
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentPurple;
        }
        return textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentPurple.withValues(alpha: 0.3);
        }
        return textTertiary.withValues(alpha: 0.3);
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentPurple;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(textPrimary),
      side: BorderSide(color: textSecondary, width: 1.5),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentPurple;
        }
        return textSecondary;
      }),
    ),

    // Progress indicator theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: accentPurple,
      linearTrackColor: textTertiary.withValues(alpha: 0.3),
      circularTrackColor: textTertiary.withValues(alpha: 0.3),
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: accentPurple,
      thumbColor: accentPurple,
      overlayColor: accentPurple.withValues(alpha: 0.2),
      inactiveTrackColor: textTertiary.withValues(alpha: 0.3),
      valueIndicatorColor: accentPurple,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Tab bar theme
    tabBarTheme: TabBarTheme(
      labelColor: accentPurple,
      unselectedLabelColor: textSecondary,
      indicatorColor: accentPurple,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: secondaryDark,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: secondaryDark,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: supportTeal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
    ),

    // Dialog theme
    dialogTheme: DialogTheme(
      backgroundColor: dialogColor,
      surfaceTintColor: Colors.transparent,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      titleTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      contentTextStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
    ),

    // List tile theme
    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: accentPurple.withValues(alpha: 0.1),
      iconColor: textSecondary,
      textColor: textPrimary,
      titleTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitleTextStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );

  /// Light theme (minimal implementation for accessibility)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: accentPurple,
      onPrimary: Colors.white,
      primaryContainer: accentPurple.withValues(alpha: 0.1),
      onPrimaryContainer: primaryDark,
      secondary: supportTeal,
      onSecondary: Colors.white,
      secondaryContainer: supportTeal.withValues(alpha: 0.1),
      onSecondaryContainer: primaryDark,
      tertiary: warningAmber,
      onTertiary: primaryDark,
      tertiaryContainer: warningAmber.withValues(alpha: 0.1),
      onTertiaryContainer: primaryDark,
      error: errorRose,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: primaryDark,
      onSurfaceVariant: textTertiary,
      outline: textTertiary.withValues(alpha: 0.3),
      outlineVariant: textTertiary.withValues(alpha: 0.1),
      shadow: shadowColor,
      scrim: shadowColor,
      inverseSurface: primaryDark,
      onInverseSurface: textPrimary,
      inversePrimary: accentPurple,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: _buildTextTheme(isLight: true),
  );

  /// Helper method to build text theme with Inter and JetBrains Mono fonts
  static TextTheme _buildTextTheme({bool isLight = false}) {
    final Color primaryTextColor = isLight ? primaryDark : textPrimary;
    final Color secondaryTextColor = isLight ? textTertiary : textSecondary;
    final Color tertiaryTextColor =
        isLight ? textTertiary.withValues(alpha: 0.7) : textTertiary;

    return TextTheme(
      // Display styles - Inter for headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Inter for headings
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Inter for headings
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Inter for body text (optimized for confession reading)
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Inter for UI labels, JetBrains Mono for data
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: tertiaryTextColor,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }
}
