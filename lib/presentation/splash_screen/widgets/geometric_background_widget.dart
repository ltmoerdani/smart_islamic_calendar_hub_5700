import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class GeometricBackgroundWidget extends StatefulWidget {
  const GeometricBackgroundWidget({super.key});

  @override
  State<GeometricBackgroundWidget> createState() =>
      _GeometricBackgroundWidgetState();
}

class _GeometricBackgroundWidgetState extends State<GeometricBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.primaryColor,
            AppTheme.primaryVariantLight,
            AppTheme.lightTheme.primaryColor.withValues(alpha: 0.8),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated geometric patterns
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: IslamicGeometricPainter(),
                ),
              );
            },
          ),

          // Overlay gradient for depth
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Colors.transparent,
                  AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                  AppTheme.primaryVariantLight.withValues(alpha: 0.6),
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IslamicGeometricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppTheme.accentLight.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint fillPaint = Paint()
      ..color = AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    // Draw Islamic star pattern
    _drawIslamicStar(canvas, paint, fillPaint, centerX, centerY, radius * 0.3);
    _drawIslamicStar(canvas, paint, fillPaint, centerX, centerY, radius * 0.6);
    _drawIslamicStar(canvas, paint, fillPaint, centerX, centerY, radius * 0.9);

    // Draw decorative circles
    for (int i = 0; i < 8; i++) {
      final double angle = (i * 45) * (3.14159 / 180);
      final double x = centerX + (radius * 0.7) * cos(angle);
      final double y = centerY + (radius * 0.7) * sin(angle);

      canvas.drawCircle(
        Offset(x, y),
        8,
        paint,
      );
    }
  }

  void _drawIslamicStar(Canvas canvas, Paint strokePaint, Paint fillPaint,
      double centerX, double centerY, double radius) {
    final Path path = Path();
    const int points = 8;
    const double angleStep = (2 * 3.14159) / points;

    for (int i = 0; i < points; i++) {
      final double angle = i * angleStep;
      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Helper functions for trigonometry
double cos(double angle) => math.cos(angle);
double sin(double angle) => math.sin(angle);

// Import for math functions
