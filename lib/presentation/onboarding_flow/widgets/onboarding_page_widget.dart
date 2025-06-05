import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String pattern;

  const OnboardingPageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main illustration with Islamic patterns
          Container(
            width: 85.w,
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CustomImageWidget(
                    imageUrl: imageUrl,
                    width: 85.w,
                    height: 45.h,
                    fit: BoxFit.cover,
                  ),
                ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),

                // Islamic geometric pattern overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1),
                        Colors.transparent,
                        AppTheme.lightTheme.colorScheme.secondary
                            .withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),

                // Pattern-specific overlay
                _buildPatternOverlay(),
              ],
            ),
          ),

          SizedBox(height: 32),

          // Title
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          // Description
          Text(
            description,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPatternOverlay() {
    switch (pattern) {
      case 'prayer_pattern':
        return Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'access_time',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 24,
            ),
          ),
        );

      case 'calendar_pattern':
        return Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.secondary
                  .withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'calendar_today',
              color: AppTheme.lightTheme.colorScheme.onSecondary,
              size: 24,
            ),
          ),
        );

      case 'compass_pattern':
        return Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.tertiary
                  .withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'explore',
              color: Colors.black,
              size: 24,
            ),
          ),
        );

      default:
        return SizedBox.shrink();
    }
  }
}
