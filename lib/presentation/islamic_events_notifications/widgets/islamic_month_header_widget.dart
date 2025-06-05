import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class IslamicMonthHeaderWidget extends StatelessWidget {
  const IslamicMonthHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final hijriMonth = "Rajab 1446";
    final upcomingEvents = ["Laylat al-Isra", "Laylat al-Miraj"];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Islamic Month',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onPrimary
                          .withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    hijriMonth,
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onPrimary
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'calendar_month',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 28,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Upcoming Major Events',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onPrimary
                  .withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: upcomingEvents
                .map(
                  (event) => Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.onPrimary
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.onPrimary
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          event,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
