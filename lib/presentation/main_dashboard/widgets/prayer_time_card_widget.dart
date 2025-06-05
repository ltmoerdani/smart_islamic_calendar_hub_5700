import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PrayerTimeCardWidget extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final String arabicName;
  final bool isNotificationOn;
  final VoidCallback onNotificationToggle;
  final VoidCallback onTap;

  const PrayerTimeCardWidget({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.arabicName,
    required this.isNotificationOn,
    required this.onNotificationToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    prayerName,
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: onNotificationToggle,
                  child: CustomIconWidget(
                    iconName: isNotificationOn
                        ? 'notifications'
                        : 'notifications_off',
                    color: isNotificationOn
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Column(
              children: [
                Text(
                  prayerTime,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  arabicName,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    fontFamily: 'Amiri',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
