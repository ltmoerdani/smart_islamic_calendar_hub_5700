import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class LocationServicesWidget extends StatelessWidget {
  final Map<String, dynamic> settingsData;
  final Function(String, dynamic) onSettingChanged;

  const LocationServicesWidget({
    super.key,
    required this.settingsData,
    required this.onSettingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> radiusOptions = [
      "1 km",
      "3 km",
      "5 km",
      "10 km",
      "20 km"
    ];
    final List<Map<String, dynamic>> cities = [
      {"name": "Makkah", "country": "Saudi Arabia"},
      {"name": "Madinah", "country": "Saudi Arabia"},
      {"name": "Istanbul", "country": "Turkey"},
      {"name": "Cairo", "country": "Egypt"},
      {"name": "Jakarta", "country": "Indonesia"},
      {"name": "Kuala Lumpur", "country": "Malaysia"},
      {"name": "London", "country": "United Kingdom"},
      {"name": "New York", "country": "United States"},
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Location Services Toggle
          _buildSwitchTile(
            context: context,
            title: 'Location Services',
            subtitle: 'Enable GPS for accurate prayer times',
            icon: 'location_on',
            value: settingsData["locationServicesEnabled"] ?? true,
            onChanged: (value) =>
                onSettingChanged("locationServicesEnabled", value),
          ),

          Divider(height: 1),

          // Manual City Selection
          _buildSettingTile(
            context: context,
            title: 'Manual City Selection',
            subtitle: 'Choose your city manually',
            icon: 'location_city',
            onTap: () => _showCitySelectionDialog(context, cities),
          ),

          Divider(height: 1),

          // GPS Accuracy
          _buildInfoTile(
            context: context,
            title: 'GPS Accuracy',
            subtitle: 'High accuracy for precise Qibla direction',
            icon: 'gps_fixed',
            info:
                'Uses device GPS and compass for accurate Islamic calculations',
          ),

          Divider(height: 1),

          // Mosque Finder Radius
          _buildSettingTile(
            context: context,
            title: 'Mosque Finder Radius',
            subtitle: settingsData["mosqueFinderRadius"] ?? "5 km",
            icon: 'mosque',
            onTap: () => _showRadiusDialog(context, radiusOptions),
          ),

          Divider(height: 1),

          // Location Permission Status
          _buildLocationPermissionStatus(context),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: CustomIconWidget(
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
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSettingTile({
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

  Widget _buildInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String icon,
    required String info,
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
      trailing: IconButton(
        onPressed: () => _showInfoDialog(context, title, info),
        icon: CustomIconWidget(
          iconName: 'info_outline',
          color: Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLocationPermissionStatus(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.successLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.successLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check_circle',
            color: AppTheme.successLight,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location Permission Granted',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.successLight,
                      ),
                ),
                Text(
                  'App can access location for accurate Islamic calculations',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCitySelectionDialog(
      BuildContext context, List<Map<String, dynamic>> cities) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select City'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                leading: CustomIconWidget(
                  iconName: 'location_city',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
                title: Text(city["name"]),
                subtitle: Text(city["country"]),
                onTap: () {
                  onSettingChanged(
                      "selectedCity", "${city["name"]}, ${city["country"]}");
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showRadiusDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mosque Finder Radius'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => ListTile(
                    leading: CustomIconWidget(
                      iconName: 'radio_button_unchecked',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                    title: Text(option),
                    onTap: () {
                      onSettingChanged("mosqueFinderRadius", option);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String info) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(info),
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
