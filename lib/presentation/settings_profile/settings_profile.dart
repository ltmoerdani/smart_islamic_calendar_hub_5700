import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/about_section_widget.dart';
import './widgets/data_management_widget.dart';
import './widgets/display_preferences_widget.dart';
import './widgets/location_services_widget.dart';
import './widgets/prayer_settings_widget.dart';
import './widgets/settings_header_widget.dart';
import './widgets/settings_section_widget.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({super.key});

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  // Mock user data
  final Map<String, dynamic> userData = {
    "name": "Ahmed Abdullah",
    "location": "Makkah, Saudi Arabia",
    "greeting": "As-salamu alaykum",
    "lastPrayer": "Maghrib",
    "nextPrayer": "Isha",
    "profileImage":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"
  };

  // Settings state
  Map<String, dynamic> settingsData = {
    "prayerCalculationMethod": "Umm al-Qura",
    "madhab": "Hanafi",
    "theme": "Auto",
    "language": "English",
    "arabicTextSize": "Medium",
    "notificationsEnabled": true,
    "locationServicesEnabled": true,
    "mosqueFinderRadius": "5 km",
    "prayerNotifications": {
      "fajr": true,
      "dhuhr": true,
      "asr": true,
      "maghrib": true,
      "isha": true
    },
    "prePrayerWarning": "10 minutes",
    "notificationSound": "Adhan Traditional"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings & Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color:
                Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showResetDialog(),
            icon: CustomIconWidget(
              iconName: 'refresh',
              color:
                  Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header Section
              SettingsHeaderWidget(
                userData: userData,
                onProfileTap: () => _navigateToProfile(),
              ),

              SizedBox(height: 2.h),

              // Prayer Settings Section
              SettingsSectionWidget(
                title: 'Prayer Settings',
                icon: 'access_time',
                child: PrayerSettingsWidget(
                  settingsData: settingsData,
                  onSettingChanged: _updateSetting,
                ),
              ),

              SizedBox(height: 2.h),

              // Display Preferences Section
              SettingsSectionWidget(
                title: 'Display Preferences',
                icon: 'palette',
                child: DisplayPreferencesWidget(
                  settingsData: settingsData,
                  onSettingChanged: _updateSetting,
                ),
              ),

              SizedBox(height: 2.h),

              // Location Services Section
              SettingsSectionWidget(
                title: 'Location Services',
                icon: 'location_on',
                child: LocationServicesWidget(
                  settingsData: settingsData,
                  onSettingChanged: _updateSetting,
                ),
              ),

              SizedBox(height: 2.h),

              // Data Management Section
              SettingsSectionWidget(
                title: 'Data Management',
                icon: 'storage',
                child: DataManagementWidget(
                  onAction: _handleDataAction,
                ),
              ),

              SizedBox(height: 2.h),

              // About Section
              SettingsSectionWidget(
                title: 'About',
                icon: 'info',
                child: AboutSectionWidget(
                  onAction: _handleAboutAction,
                ),
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSetting(String key, dynamic value) {
    setState(() {
      if (key.contains('.')) {
        final keys = key.split('.');
        if (keys.length == 2) {
          (settingsData[keys[0]] as Map<String, dynamic>)[keys[1]] = value;
        }
      } else {
        settingsData[key] = value;
      }
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Setting updated successfully'),
        duration: Duration(seconds: 2),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleDataAction(String action) {
    switch (action) {
      case 'backup':
        _showBackupDialog();
        break;
      case 'restore':
        _showRestoreDialog();
        break;
      case 'clearCache':
        _showClearCacheDialog();
        break;
      case 'downloadQuran':
        _showDownloadDialog();
        break;
    }
  }

  void _handleAboutAction(String action) {
    switch (action) {
      case 'feedback':
        _showFeedbackDialog();
        break;
      case 'privacy':
        _showPrivacyDialog();
        break;
      case 'terms':
        _showTermsDialog();
        break;
      case 'version':
        _showVersionDialog();
        break;
    }
  }

  void _navigateToProfile() {
    // Navigate to detailed profile screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(userData["profileImage"]),
            ),
            SizedBox(height: 16),
            Text(userData["name"],
                style: Theme.of(context).textTheme.titleMedium),
            Text(userData["location"],
                style: Theme.of(context).textTheme.bodyMedium),
          ],
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

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Settings'),
        content: Text(
            'Are you sure you want to reset all settings to default Islamic calculation methods?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                settingsData = {
                  "prayerCalculationMethod": "Umm al-Qura",
                  "madhab": "Hanafi",
                  "theme": "Auto",
                  "language": "English",
                  "arabicTextSize": "Medium",
                  "notificationsEnabled": true,
                  "locationServicesEnabled": true,
                  "mosqueFinderRadius": "5 km",
                  "prayerNotifications": {
                    "fajr": true,
                    "dhuhr": true,
                    "asr": true,
                    "maghrib": true,
                    "isha": true
                  },
                  "prePrayerWarning": "10 minutes",
                  "notificationSound": "Adhan Traditional"
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Settings reset to defaults')),
              );
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Backup Data'),
        content: Text(
            'Your Islamic bookmarks and prayer settings will be backed up securely.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Backup completed successfully')),
              );
            },
            child: Text('Backup'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Restore Data'),
        content: Text(
            'Restore your Islamic bookmarks and prayer settings from backup.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data restored successfully')),
              );
            },
            child: Text('Restore'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text(
            'This will clear temporary files and downloaded content. Quran audio may need to be re-downloaded.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Download Quran'),
        content: Text(
            'Download complete Quran with audio recitation for offline access.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Download started')),
              );
            },
            child: Text('Download'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Community Feedback'),
        content: Text(
            'Share your experience with the Islamic Calendar Hub community.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Feedback form opened')),
              );
            },
            child: Text('Give Feedback'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. We collect location data only for accurate prayer times and Qibla direction. Religious data is stored securely on your device.',
            style: Theme.of(context).textTheme.bodyMedium,
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

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terms of Service'),
        content: SingleChildScrollView(
          child: Text(
            'By using this Islamic Calendar Hub, you agree to use it for religious purposes in accordance with Islamic principles.',
            style: Theme.of(context).textTheme.bodyMedium,
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

  void _showVersionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('App Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Islamic Calendar Hub'),
            Text('Version: 1.0.0'),
            Text('Build: 2024.1'),
            SizedBox(height: 8),
            Text('Developed with Islamic principles in mind'),
          ],
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
