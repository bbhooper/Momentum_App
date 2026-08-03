import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'momentum_palette.dart';

class MomentumTheme {
  const MomentumTheme._();

  static ThemeData get inkLight {
    return _createTheme(
      brightness: Brightness.light,
      palette: MomentumPalette.inkLight,
    );
  }

  static ThemeData get inkDark {
    return _createTheme(
      brightness: Brightness.dark,
      palette: MomentumPalette.inkDark,
    );
  }

  static ThemeData _createTheme({
    required Brightness brightness,
    required MomentumPalette palette,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: palette.primaryInk,
      onPrimary: palette.notebook,
      secondary: palette.accent,
      onSecondary: palette.accentInk,
      error: palette.error,
      onError: palette.notebook,
      surface: palette.card,
      onSurface: palette.primaryInk,
    );

    final loraTextTheme = GoogleFonts.loraTextTheme(
      ThemeData(brightness: brightness, colorScheme: colorScheme).textTheme,
    );

    // copyWith preserves Lora's font family while applying Momentum's
    // typography sizes, weights and colours.
    final textTheme = loraTextTheme.copyWith(
      displaySmall: loraTextTheme.displaySmall?.copyWith(
        fontSize: 36,
        height: 1.1,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.6,
        color: palette.primaryInk,
      ),
      headlineLarge: loraTextTheme.headlineLarge?.copyWith(
        fontSize: 30,
        height: 1.15,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.4,
        color: palette.primaryInk,
      ),
      headlineMedium: loraTextTheme.headlineMedium?.copyWith(
        fontSize: 24,
        height: 1.2,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.25,
        color: palette.primaryInk,
      ),
      titleLarge: loraTextTheme.titleLarge?.copyWith(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.15,
        color: palette.primaryInk,
      ),
      titleMedium: loraTextTheme.titleMedium?.copyWith(
        fontSize: 17,
        height: 1.3,
        fontWeight: FontWeight.w500,
        color: palette.primaryInk,
      ),
      bodyLarge: loraTextTheme.bodyLarge?.copyWith(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: palette.primaryInk,
      ),
      bodyMedium: loraTextTheme.bodyMedium?.copyWith(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: palette.primaryInk,
      ),
      bodySmall: loraTextTheme.bodySmall?.copyWith(
        fontSize: 12,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: palette.secondaryInk,
      ),
      labelLarge: loraTextTheme.labelLarge?.copyWith(
        fontSize: 15,
        height: 1.25,
        fontWeight: FontWeight.w600,
        color: palette.primaryInk,
      ),
      labelMedium: loraTextTheme.labelMedium?.copyWith(
        fontSize: 13,
        height: 1.25,
        fontWeight: FontWeight.w500,
        color: palette.secondaryInk,
      ),
      labelSmall: loraTextTheme.labelSmall?.copyWith(
        fontSize: 11,
        height: 1.25,
        fontWeight: FontWeight.w500,
        color: palette.secondaryInk,
      ),
    );

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: palette.divider),
    );

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.notebook,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[palette],
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      dividerColor: palette.divider,
      iconTheme: IconThemeData(color: palette.primaryInk),

      cardTheme: CardThemeData(
        color: palette.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: palette.divider),
        ),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: palette.notebook,
        foregroundColor: palette.primaryInk,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineMedium,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: palette.secondaryInk),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(
          color: palette.secondaryInk,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: palette.secondaryInk.withValues(alpha: 0.75),
        ),
        helperStyle: textTheme.bodySmall?.copyWith(color: palette.secondaryInk),
        errorStyle: textTheme.bodySmall?.copyWith(color: palette.error),
        prefixIconColor: palette.secondaryInk,
        suffixIconColor: palette.secondaryInk,
        enabledBorder: outlineBorder,
        disabledBorder: outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: palette.secondaryInk, width: 1.5),
        ),
        errorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: palette.error),
        ),
        focusedErrorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: palette.error, width: 1.5),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: palette.primaryInk,
          foregroundColor: palette.notebook,
          disabledBackgroundColor: palette.divider,
          disabledForegroundColor: palette.secondaryInk,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: palette.primaryInk,
          disabledForegroundColor: palette.secondaryInk,
          side: BorderSide(color: palette.divider),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.secondaryInk,
          disabledForegroundColor: palette.secondaryInk.withValues(alpha: 0.5),
          textStyle: textTheme.labelLarge,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        elevation: 0,
        backgroundColor: palette.card,
        indicatorColor: palette.accent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          return textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? palette.primaryInk
                : palette.secondaryInk,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? palette.primaryInk
                : palette.secondaryInk,
          );
        }),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.secondaryInk,
        linearTrackColor: palette.divider,
        circularTrackColor: palette.divider,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.primaryInk,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: palette.notebook,
        ),
        actionTextColor: palette.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: palette.card,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      timePickerTheme: TimePickerThemeData(
        backgroundColor: palette.card,
        dialBackgroundColor: palette.notebook,
        dialHandColor: palette.secondaryInk,
        dialTextColor: WidgetStateColor.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? palette.notebook
              : palette.primaryInk;
        }),
        hourMinuteColor: palette.accent,
        hourMinuteTextColor: palette.primaryInk,
        entryModeIconColor: palette.secondaryInk,
        helpTextStyle: textTheme.labelMedium,
        dayPeriodTextColor: palette.primaryInk,
        dayPeriodColor: palette.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
