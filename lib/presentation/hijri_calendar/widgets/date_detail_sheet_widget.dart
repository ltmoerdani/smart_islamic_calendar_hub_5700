import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DateDetailSheetWidget extends StatelessWidget {
  final Map<String, dynamic> dateData;
  final VoidCallback onClose;

  const DateDetailSheetWidget({
    super.key,
    required this.dateData,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final int hijriDay = dateData['hijriDay'] as int? ?? 0;
    final int gregorianDay = dateData['gregorianDay'] as int? ?? 0;
    final bool hasEvent = dateData['hasEvent'] as bool? ?? false;
    final String moonPhase = dateData['moonPhase'] as String? ?? '';
    final String islamicSignificance =
        dateData['islamicSignificance'] as String? ?? '';
    final List<Map<String, dynamic>> events =
        (dateData['events'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date Details',
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date information card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Hijri Date',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  hijriDay.toString(),
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineMedium
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 8.h,
                              color: AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.3),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Gregorian Date',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  gregorianDay.toString(),
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineMedium
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Moon phase
                  if (moonPhase.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.secondary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: _getMoonPhaseIcon(moonPhase),
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Moon Phase',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.secondary,
                                ),
                              ),
                              Text(
                                _getMoonPhaseName(moonPhase),
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 3.h),

                  // Islamic significance
                  if (islamicSignificance.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.tertiary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'auto_stories',
                                color: AppTheme.lightTheme.colorScheme.tertiary,
                                size: 20,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Islamic Significance',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            islamicSignificance,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 3.h),

                  // Events
                  if (hasEvent && events.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Events',
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ...events.map((event) => _buildEventCard(event)),
                      ],
                    ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final String title = event['title'] as String? ?? '';
    final String type = event['type'] as String? ?? '';
    final String description = event['description'] as String? ?? '';

    Color getTypeColor() {
      switch (type) {
        case 'holiday':
          return AppTheme.lightTheme.colorScheme.error;
        case 'religious':
          return AppTheme.lightTheme.colorScheme.primary;
        case 'fasting':
          return AppTheme.lightTheme.colorScheme.secondary;
        case 'prayer':
          return AppTheme.lightTheme.colorScheme.tertiary;
        default:
          return AppTheme.lightTheme.colorScheme.primary;
      }
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: getTypeColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: getTypeColor().withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: getTypeColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  type.toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (description.isNotEmpty) ...[
            SizedBox(height: 1.h),
            Text(
              description,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
                height: 1.4,
              ),
            ),
          ],
        ],
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

  String _getMoonPhaseName(String phase) {
    switch (phase) {
      case 'new_moon':
        return 'New Moon';
      case 'first_quarter':
        return 'First Quarter';
      case 'full_moon':
        return 'Full Moon';
      case 'last_quarter':
        return 'Last Quarter';
      default:
        return 'Unknown';
    }
  }
}
