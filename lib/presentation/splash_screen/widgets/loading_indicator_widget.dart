import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  final String loadingText;
  final bool isInitialized;

  const LoadingIndicatorWidget({
    super.key,
    required this.loadingText,
    required this.isInitialized,
  });

  @override
  State<LoadingIndicatorWidget> createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Loading indicator
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: widget.isInitialized
                    ? CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successLight,
                        size: 24,
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.lightTheme.colorScheme.surface,
                          ),
                        ),
                      ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // Loading text
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            widget.loadingText,
            key: ValueKey(widget.loadingText),
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.lightTheme.colorScheme.surface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 8),

        // Progress dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300 + (index * 100)),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: widget.isInitialized ? 8 : 6,
              height: widget.isInitialized ? 8 : 6,
              decoration: BoxDecoration(
                color: widget.isInitialized
                    ? AppTheme.successLight
                    : AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
