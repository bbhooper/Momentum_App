import 'package:flutter/material.dart';

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

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.notebook,
      fontFamily: 'Georgia',
      extensions: <ThemeExtension<dynamic>>[
        palette,
      ],
    );

    final textTheme = baseTheme.textTheme.copyWith(
      displaySmall: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 36,
        height: 1.1,
        fontWeight: FontWeight.w400,
        color: palette.primaryInk,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 30,
        height: 1.15,
        fontWeight: FontWeight.w400,
        color: palette.primaryInk,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 24,
        height: 1.2,
        fontWeight: FontWeight.w400,
        color: palette.primaryInk,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w500,
        color: palette.primaryInk,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 17,
        height: 1.3,
        fontWeight: FontWeight.w500,
        color: palette.primaryInk,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 16,
        height: 1.5,
        color: palette.primaryInk,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 14,
        height: 1.45,
        color: palette.primaryInk,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 12,
        height: 1.4,
        color: palette.secondaryInk,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: palette.primaryInk,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: palette.secondaryInk,
      ),
    );

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: palette.divider),
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      dividerColor: palette.divider,
      cardTheme: CardThemeData(
        color: palette.card,
        elevation: 0,
        margin: EdgeInsets.zero,
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
        titleTextStyle: textTheme.headlineMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        labelStyle: TextStyle(color: palette.secondaryInk),
        hintStyle: TextStyle(
          color: palette.secondaryInk.withValues(alpha: 0.75),
        ),
        helperStyle: TextStyle(color: palette.secondaryInk),
        errorStyle: TextStyle(color: palette.error),
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: BorderSide(
            color: palette.secondaryInk,
            width: 1.5,
          ),
        ),
        errorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: palette.error),
        ),
        focusedErrorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(
            color: palette.error,
            width: 1.5,
          ),
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
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? palette.primaryInk
                : palette.secondaryInk,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.card,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: palette.card,
        dialBackgroundColor: palette.notebook,
        dialHandColor: palette.secondaryInk,
        hourMinuteColor: palette.accent,
        hourMinuteTextColor: palette.primaryInk,
        entryModeIconColor: palette.secondaryInk,
        helpTextStyle: textTheme.labelMedium,
        dayPeriodTextColor: palette.primaryInk,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}