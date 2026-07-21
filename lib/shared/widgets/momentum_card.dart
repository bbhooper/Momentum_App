import 'package:flutter/material.dart';

import '../../core/theme/momentum_palette.dart';
import 'textured_page.dart';

class MomentumCard extends StatelessWidget {
  const MomentumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.divider,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primaryInk.withValues(
              alpha: isDark ? 0.10 : 0.045,
            ),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: CustomPaint(
          painter: PaperTexturePainter(
            color: colors.primaryInk,
            opacity: isDark ? 0.027 : 0.022,
            seed: 43,
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );

    return Padding(
      padding: margin,
      child: onTap == null
          ? content
          : Semantics(
              button: true,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: content,
                ),
              ),
            ),
    );
  }
}