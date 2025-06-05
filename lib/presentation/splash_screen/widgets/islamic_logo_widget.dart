import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class IslamicLogoWidget extends StatelessWidget {
  const IslamicLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer decorative ring
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.accentLight,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),

          // Inner content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Crescent and star symbol
              CustomIconWidget(
                iconName: 'brightness_2',
                color: AppTheme.lightTheme.primaryColor,
                size: 32,
              ),

              const SizedBox(height: 4),

              // Arabic calligraphy text
              Text(
                'التقويم الإسلامي',
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              // English app name
              Text(
                'Islamic Calendar',
                style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMediumEmphasisLight,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
