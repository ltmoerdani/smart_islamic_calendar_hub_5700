import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PrayerSettingsWidget extends StatelessWidget {
  final Map<String, dynamic> settingsData;
  final Function(String, dynamic) onSettingChanged;

  const PrayerSettingsWidget({
    super.key,
    required this.settingsData,
    required this.onSettingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> calculationMethods = [
      {"name": "Umm al-Qura", "description": "Used in Saudi Arabia"},
      {"name": "ISNA", "description": "Islamic Society of North America"},
      {"name": "MWL", "description": "Muslim World League"},
      {"name": "Egyptian", "description": "Egyptian General Authority"},
      {"name": "Karachi", "description": "University of Islamic Sciences"},
    ];

    final List<String> madhabOptions = ["Hanafi", "Shafi", "Maliki", "Hanbali"];
    final List<String> warningTimes = [
      "5 minutes",
      "10 minutes",
      "15 minutes",
      "30 minutes"
    ];
    final List<String> notificationSounds = [
      "Adhan Traditional",
      "Adhan Makkah",
      "Adhan Madinah",
      "Simple Bell"
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Prayer Calculation Method
          _buildSettingTile(
            context: context,
            title: 'Calculation Method',
            subtitle: settingsData["prayerCalculationMethod"] ?? "Umm al-Qura",
            onTap: () =>
                _showCalculationMethodDialog(context, calculationMethods),
          ),

          Divider(height: 1),

          // Madhab Selection
          _buildSettingTile(
            context: context,
            title: 'Madhab',
            subtitle: settingsData["madhab"] ?? "Hanafi",
            onTap: () => _showMadhabDialog(context, madhabOptions),
          ),

          Divider(height: 1),

          // Prayer Notifications Toggle
          _buildSwitchTile(
            context: context,
            title: 'Prayer Notifications',
            subtitle: 'Enable prayer time alerts',
            value: settingsData["notificationsEnabled"] ?? true,
            onChanged: (value) =>
                onSettingChanged("notificationsEnabled", value),
          ),

          Divider(height: 1),

          // Individual Prayer Toggles
          _buildExpandableTile(
            context: context,
            title: 'Individual Prayer Alerts',
            subtitle: 'Customize each prayer notification',
            children: [
              _buildPrayerToggle(context, 'Fajr', 'fajr'),
              _buildPrayerToggle(context, 'Dhuhr', 'dhuhr'),
              _buildPrayerToggle(context, 'Asr', 'asr'),
              _buildPrayerToggle(context, 'Maghrib', 'maghrib'),
              _buildPrayerToggle(context, 'Isha', 'isha'),
            ],
          ),

          Divider(height: 1),

          // Pre-prayer Warning
          _buildSettingTile(
            context: context,
            title: 'Pre-prayer Warning',
            subtitle: settingsData["prePrayerWarning"] ?? "10 minutes",
            onTap: () => _showWarningTimeDialog(context, warningTimes),
          ),

          Divider(height: 1),

          // Notification Sound
          _buildSettingTile(
            context: context,
            title: 'Notification Sound',
            subtitle: settingsData["notificationSound"] ?? "Adhan Traditional",
            onTap: () =>
                _showNotificationSoundDialog(context, notificationSounds),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
      ),
      trailing: CustomIconWidget(
        iconName: 'chevron_right',
        color: Colors.grey,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildExpandableTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      children: children,
    );
  }

  Widget _buildPrayerToggle(
      BuildContext context, String prayerName, String key) {
    final prayerNotifications =
        settingsData["prayerNotifications"] as Map<String, dynamic>? ?? {};
    return SwitchListTile(
      title: Text(prayerName),
      value: prayerNotifications[key] ?? true,
      onChanged: (value) => onSettingChanged("prayerNotifications.$key", value),
      contentPadding: EdgeInsets.only(left: 32, right: 16),
    );
  }

  void _showCalculationMethodDialog(
      BuildContext context, List<Map<String, dynamic>> methods) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Prayer Calculation Method'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: methods
                .map((method) => ListTile(
                      title: Text(method["name"]),
                      subtitle: Text(method["description"]),
                      onTap: () {
                        onSettingChanged(
                            "prayerCalculationMethod", method["name"]);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showMadhabDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Madhab'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => ListTile(
                    title: Text(option),
                    onTap: () {
                      onSettingChanged("madhab", option);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showWarningTimeDialog(BuildContext context, List<String> times) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pre-prayer Warning Time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: times
              .map((time) => ListTile(
                    title: Text(time),
                    onTap: () {
                      onSettingChanged("prePrayerWarning", time);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showNotificationSoundDialog(BuildContext context, List<String> sounds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notification Sound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: sounds
              .map((sound) => ListTile(
                    title: Text(sound),
                    onTap: () {
                      onSettingChanged("notificationSound", sound);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
