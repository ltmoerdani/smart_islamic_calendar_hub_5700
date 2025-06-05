import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CalendarDayCellWidget extends StatelessWidget {
  final Map<String, dynamic> dayData;
  final bool isHijriPrimary;
  final VoidCallback onTapped;
  final VoidCallback onLongPressed;

  const CalendarDayCellWidget({
    super.key,
    required this.dayData,
    required this.isHijriPrimary,
    required this.onTapped,
    required this.onLongPressed,
  });

  Color _getEventColor() {
    final String eventType = dayData['eventType'] as String? ?? '';
    switch (eventType) {
      case 'holiday':
        return AppTheme.lightTheme.colorScheme.error;
      case 'religious':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'fasting':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'prayer':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'community':
        return AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.7);
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isToday = dayData['isToday'] as bool? ?? false;
    final bool hasEvent = dayData['hasEvent'] as bool? ?? false;
    final int hijriDay = dayData['hijriDay'] as int? ?? 0;
    final int gregorianDay = dayData['gregorianDay'] as int? ?? 0;
    final String moonPhase = dayData['moonPhase'] as String? ?? '';

    return GestureDetector(
      onTap: onTapped,
      onLongPress: onLongPressed,
      child: Container(
        margin: EdgeInsets.all(0.5.w),
        decoration: BoxDecoration(
          color: isToday
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.2)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 2,
                )
              : Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  width: 0.5,
                ),
          boxShadow: isToday
              ? [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.all(1.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Primary date (Hijri or Gregorian)
                  Text(
                    isHijriPrimary
                        ? hijriDay.toString()
                        : gregorianDay.toString(),
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: isToday
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),

                  // Secondary date (smaller)
                  if (hijriDay > 0 && gregorianDay > 0)
                    Text(
                      isHijriPrimary
                          ? gregorianDay.toString()
                          : hijriDay.toString(),
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                        fontSize: 8.sp,
                      ),
                    ),
                ],
              ),
            ),

            // Event indicator
            if (hasEvent)
              Positioned(
                top: 1.w,
                right: 1.w,
                child: Container(
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: _getEventColor(),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

            // Moon phase indicator
            if (moonPhase.isNotEmpty)
              Positioned(
                bottom: 1.w,
                left: 1.w,
                child: CustomIconWidget(
                  iconName: _getMoonPhaseIcon(moonPhase),
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.4),
                  size: 8,
                ),
              ),

            // Today indicator
            if (isToday)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 4.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'today',
                      color: Colors.white,
                      size: 8,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMoonPhaseIcon(String phase) {
    switch (phase) {
      case 'new_moon':
        return 'brightness_1';
      case 'first_quarter':
        return 'brightness_2';
      case 'full_moon':
        return 'brightness_7';
      case 'last_quarter':
        return 'brightness_3';
      default:
        return 'brightness_1';
    }
  }
}
