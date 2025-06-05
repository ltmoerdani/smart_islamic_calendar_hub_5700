import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './prayer_time_card_widget.dart';

class PrayerTimesListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> prayerTimes;

  const PrayerTimesListWidget({
    super.key,
    required this.prayerTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Prayer Times',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to detailed prayer times
                },
                child: Text(
                  'View All',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: prayerTimes.length,
            itemBuilder: (context, index) {
              final prayer = prayerTimes[index];
              return Padding(
                padding: EdgeInsets.only(right: 3.w),
                child: PrayerTimeCardWidget(
                  prayerName: prayer["name"] as String,
                  prayerTime: prayer["time"] as String,
                  arabicName: prayer["arabicName"] as String,
                  isNotificationOn: prayer["isNotificationOn"] as bool,
                  onNotificationToggle: () {
                    // Handle notification toggle
                  },
                  onTap: () {
                    // Handle prayer card tap
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
