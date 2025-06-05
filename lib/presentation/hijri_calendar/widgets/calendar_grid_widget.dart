import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './calendar_day_cell_widget.dart';

class CalendarGridWidget extends StatelessWidget {
  final Map<String, dynamic> monthData;
  final bool isHijriPrimary;
  final Function(Map<String, dynamic>) onDateTapped;
  final Function(Map<String, dynamic>) onDateLongPressed;
  final bool isLoading;

  const CalendarGridWidget({
    super.key,
    required this.monthData,
    required this.isHijriPrimary,
    required this.onDateTapped,
    required this.onDateLongPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ];
    final List<Map<String, dynamic>> days =
        (monthData['days'] as List).cast<Map<String, dynamic>>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Weekday headers
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              children: weekdays.map((weekday) {
                final bool isFriday = weekday == 'Fri';
                return Expanded(
                  child: Center(
                    child: Text(
                      weekday,
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: isFriday
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                        fontWeight:
                            isFriday ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Calendar grid
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: 42, // 6 weeks * 7 days
                    itemBuilder: (context, index) {
                      final int dayIndex =
                          index - 6; // Start from Sunday, accounting for offset

                      if (dayIndex < 0 || dayIndex >= days.length) {
                        // Empty cells for previous/next month
                        return Container();
                      }

                      final Map<String, dynamic> dayData = days[dayIndex];

                      return CalendarDayCellWidget(
                        dayData: dayData,
                        isHijriPrimary: isHijriPrimary,
                        onTapped: () => onDateTapped(dayData),
                        onLongPressed: () => onDateLongPressed(dayData),
                      );
                    },
                  ),
          ),

          // Legend
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Wrap(
              spacing: 4.w,
              runSpacing: 1.h,
              alignment: WrapAlignment.center,
              children: [
                _buildLegendItem(
                  'Holiday',
                  AppTheme.lightTheme.colorScheme.error,
                ),
                _buildLegendItem(
                  'Religious',
                  AppTheme.lightTheme.colorScheme.primary,
                ),
                _buildLegendItem(
                  'Fasting',
                  AppTheme.lightTheme.colorScheme.secondary,
                ),
                _buildLegendItem(
                  'Prayer',
                  AppTheme.lightTheme.colorScheme.tertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
