import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DailyQuoteWidget extends StatelessWidget {
  final Map<String, dynamic> quote;

  const DailyQuoteWidget({
    super.key,
    required this.quote,
  });

  void _shareQuote() {
    final String shareText = '${quote["text"]}\n\n- ${quote["reference"]}';
    // Share functionality would be implemented here
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'format_quote',
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Daily Inspiration',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _shareQuote,
                icon: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            quote["arabic"] as String,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontFamily: 'Amiri',
              color: AppTheme.lightTheme.primaryColor,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 2.h),
          Text(
            quote["text"] as String,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 1.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '- ${quote["reference"]}',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
