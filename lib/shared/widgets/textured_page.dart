import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/momentum_palette.dart';

class TexturedPage extends StatelessWidget {
  const TexturedPage({
    super.key,
    required this.child,
    this.textureAsset = 'assets/images/notebook_paper03.jpg',
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
  });

  final Widget child;
  final String textureAsset;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: colors.notebook,
      child: Stack(
        fit: StackFit.expand,
        children: [
          IgnorePointer(
            child: Opacity(
              opacity: isDark ? 0.18 : 0.22,
              child: Image.asset(
                textureAsset,
                fit: BoxFit.cover,
                color: colors.primaryInk.withValues(
                  alpha: isDark ? 0.55 : 0.32,
                ),
                colorBlendMode: isDark
                    ? BlendMode.softLight
                    : BlendMode.multiply,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          ),
          SafeArea(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}

/// Retained for the subtler procedural texture used by [MomentumCard].
class PaperTexturePainter extends CustomPainter {
  const PaperTexturePainter({
    required this.color,
    required this.opacity,
    required this.seed,
  });

  final Color color;
  final double opacity;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed);

    final grainPaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round;

    final grainCount = (size.width * size.height / 550).round();

    for (var index = 0; index < grainCount; index++) {
      final start = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );

      final length = 1.5 + random.nextDouble() * 5;
      final angle = random.nextDouble() * math.pi;

      final end = Offset(
        start.dx + math.cos(angle) * length,
        start.dy + math.sin(angle) * length,
      );

      canvas.drawLine(start, end, grainPaint);
    }

    final specklePaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.7);

    final speckleCount = (size.width * size.height / 1000).round();

    for (var index = 0; index < speckleCount; index++) {
      final position = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );

      canvas.drawCircle(
        position,
        0.25 + random.nextDouble() * 0.45,
        specklePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PaperTexturePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.opacity != opacity ||
        oldDelegate.seed != seed;
  }
}
