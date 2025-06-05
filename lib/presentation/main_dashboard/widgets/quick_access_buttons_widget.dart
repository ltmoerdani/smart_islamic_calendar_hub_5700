import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickAccessButtonsWidget extends StatelessWidget {
  const QuickAccessButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickActions = [
      {
        "title": "Tasbih Counter",
        "subtitle": "Digital prayer beads",
        "icon": "radio_button_checked",
        "color": AppTheme.lightTheme.primaryColor,
        "onTap": () { /* Navigate to Tasbih counter */ }
      },
      {
        "title": "Zakat Calculator",
        "subtitle": "Calculate your Zakat",
        "icon": "calculate",
        "color": AppTheme.lightTheme.colorScheme.secondary,
        "onTap": () { /* Navigate to Zakat calculator */ }
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Quick Access',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: quickActions.map((action) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: action == quickActions.last ? 0 : 3.w,
                  ),
                  child: GestureDetector(
                    onTap: action["onTap"] as VoidCallback,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (action["color"] as Color).withValues(alpha: 0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightTheme.colorScheme.shadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: (action["color"] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomIconWidget(
                              iconName: action["icon"] as String,
                              color: action["color"] as Color,
                              size: 28,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            action["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            action["subtitle"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}