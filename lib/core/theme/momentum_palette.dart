import 'package:flutter/material.dart';

@immutable
class MomentumPalette extends ThemeExtension<MomentumPalette> {
  const MomentumPalette({
    required this.notebook,
    required this.card,
    required this.primaryInk,
    required this.secondaryInk,
    required this.accent,
    required this.accentInk,
    required this.divider,
    required this.success,
    required this.warning,
    required this.error,
  });

  final Color notebook;
  final Color card;
  final Color primaryInk;
  final Color secondaryInk;
  final Color accent;
  final Color accentInk;
  final Color divider;
  final Color success;
  final Color warning;
  final Color error;

  static const MomentumPalette inkLight = MomentumPalette(
    notebook: Color(0xFFF7F5F1),
    card: Color(0xFFFCFBF8),
    primaryInk: Color(0xFF1E2436),
    secondaryInk: Color(0xFF5E6E8B),
    accent: Color(0xFFD6DBCC),
    accentInk: Color(0xFF30382D),
    divider: Color(0xFFE4E1DA),
    success: Color(0xFF65785F),
    warning: Color(0xFFA6773D),
    error: Color(0xFFA64F4F),
  );

  static const MomentumPalette inkDark = MomentumPalette(
    notebook: Color(0xFF141A28),
    card: Color(0xFF1F2534),
    primaryInk: Color(0xFFEDEFF3),
    secondaryInk: Color(0xFF8FA2C2),
    accent: Color(0xFF93A88C),
    accentInk: Color(0xFF172016),
    divider: Color(0xFF30384A),
    success: Color(0xFF9CB497),
    warning: Color(0xFFD1A469),
    error: Color(0xFFD98686),
  );

  @override
  MomentumPalette copyWith({
    Color? notebook,
    Color? card,
    Color? primaryInk,
    Color? secondaryInk,
    Color? accent,
    Color? accentInk,
    Color? divider,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return MomentumPalette(
      notebook: notebook ?? this.notebook,
      card: card ?? this.card,
      primaryInk: primaryInk ?? this.primaryInk,
      secondaryInk: secondaryInk ?? this.secondaryInk,
      accent: accent ?? this.accent,
      accentInk: accentInk ?? this.accentInk,
      divider: divider ?? this.divider,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  MomentumPalette lerp(
    covariant ThemeExtension<MomentumPalette>? other,
    double t,
  ) {
    if (other is! MomentumPalette) {
      return this;
    }

    return MomentumPalette(
      notebook: Color.lerp(notebook, other.notebook, t)!,
      card: Color.lerp(card, other.card, t)!,
      primaryInk: Color.lerp(primaryInk, other.primaryInk, t)!,
      secondaryInk: Color.lerp(secondaryInk, other.secondaryInk, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

extension MomentumThemeContext on BuildContext {
  MomentumPalette get momentumColors {
    return Theme.of(this).extension<MomentumPalette>()!;
  }
}
