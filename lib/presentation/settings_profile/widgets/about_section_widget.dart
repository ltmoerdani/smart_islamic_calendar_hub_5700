import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AboutSectionWidget extends StatelessWidget {
  final Function(String) onAction;

  const AboutSectionWidget({
    super.key,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // App Version
          _buildInfoTile(
            context: context,
            title: 'App Version',
            subtitle: '1.0.0 (Build 2024.1)',
            icon: 'info',
            onTap: () => onAction('version'),
          ),

          Divider(height: 1),

          // Islamic Calendar Info
          _buildInfoTile(
            context: context,
            title: 'Islamic Calendar Information',
            subtitle: 'Learn about Hijri calendar system',
            icon: 'calendar_today',
            onTap: () => _showIslamicCalendarInfo(context),
          ),

          Divider(height: 1),

          // Community Feedback
          _buildInfoTile(
            context: context,
            title: 'Community Feedback',
            subtitle: 'Share your experience',
            icon: 'feedback',
            onTap: () => onAction('feedback'),
          ),

          Divider(height: 1),

          // Privacy Policy
          _buildInfoTile(
            context: context,
            title: 'Privacy Policy',
            subtitle: 'How we protect your data',
            icon: 'privacy_tip',
            onTap: () => onAction('privacy'),
          ),

          Divider(height: 1),

          // Terms of Service
          _buildInfoTile(
            context: context,
            title: 'Terms of Service',
            subtitle: 'Usage terms and conditions',
            icon: 'description',
            onTap: () => onAction('terms'),
          ),

          Divider(height: 1),

          // Developer Info
          _buildDeveloperInfo(context),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.colorScheme.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: CustomIconWidget(
        iconName: 'chevron_right',
        color: Colors.grey,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDeveloperInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'mosque',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Islamic Calendar Hub',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Developed with Islamic principles in mind',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Amiri',
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'In the name of Allah, the Most Gracious, the Most Merciful',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureHighlight(context, 'Prayer Times', 'access_time'),
              _buildFeatureHighlight(context, 'Qibla Finder', 'explore'),
              _buildFeatureHighlight(
                  context, 'Hijri Calendar', 'calendar_today'),
              _buildFeatureHighlight(context, 'Quran Reader', 'menu_book'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlight(
      BuildContext context, String title, String icon) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showIslamicCalendarInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Islamic Calendar System'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The Islamic calendar (Hijri calendar) is a lunar calendar consisting of 12 months in a year of 354 or 355 days.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 12),
              Text(
                'Key Features:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              Text('• Based on lunar cycles'),
              Text('• 354-355 days per year'),
              Text('• Starts from Prophet Muhammad\'s migration (Hijra)'),
              Text('• Used for Islamic religious observances'),
              Text('• Determines dates for Ramadan, Hajj, and Eid'),
              SizedBox(height: 12),
              Text(
                'This app provides accurate Hijri dates and Islamic event calculations based on astronomical data.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
