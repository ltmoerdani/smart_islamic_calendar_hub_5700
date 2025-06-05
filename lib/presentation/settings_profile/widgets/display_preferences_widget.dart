import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class DisplayPreferencesWidget extends StatelessWidget {
  final Map<String, dynamic> settingsData;
  final Function(String, dynamic) onSettingChanged;

  const DisplayPreferencesWidget({
    super.key,
    required this.settingsData,
    required this.onSettingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> themeOptions = ["Light", "Dark", "Auto"];
    final List<String> languageOptions = [
      "English",
      "Arabic",
      "Urdu",
      "Turkish",
      "Indonesian",
      "Malay"
    ];
    final List<String> textSizeOptions = [
      "Small",
      "Medium",
      "Large",
      "Extra Large"
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Theme Selection
          _buildSettingTile(
            context: context,
            title: 'Theme',
            subtitle: settingsData["theme"] ?? "Auto",
            icon: 'brightness_6',
            onTap: () => _showThemeDialog(context, themeOptions),
          ),

          Divider(height: 1),

          // Language Selection
          _buildSettingTile(
            context: context,
            title: 'Language',
            subtitle: settingsData["language"] ?? "English",
            icon: 'language',
            onTap: () => _showLanguageDialog(context, languageOptions),
          ),

          Divider(height: 1),

          // Arabic Text Size
          _buildSettingTile(
            context: context,
            title: 'Arabic Text Size',
            subtitle: settingsData["arabicTextSize"] ?? "Medium",
            icon: 'format_size',
            onTap: () => _showTextSizeDialog(context, textSizeOptions),
          ),

          Divider(height: 1),

          // Theme Preview
          _buildThemePreview(context),
        ],
      ),
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

  Widget _buildThemePreview(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'palette',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Islamic Color Palette Preview',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorSwatch(
                  'Primary', AppTheme.lightTheme.colorScheme.primary),
              _buildColorSwatch(
                  'Secondary', AppTheme.lightTheme.colorScheme.secondary),
              _buildColorSwatch('Accent', AppTheme.accentLight),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Sacred Serenity - Islamic inspired colors',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => ListTile(
                    leading: CustomIconWidget(
                      iconName: option == 'Light'
                          ? 'light_mode'
                          : option == 'Dark'
                              ? 'dark_mode'
                              : 'brightness_auto',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 24,
                    ),
                    title: Text(option),
                    onTap: () {
                      onSettingChanged("theme", option);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map((option) => ListTile(
                      leading: CustomIconWidget(
                        iconName: 'language',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 24,
                      ),
                      title: Text(option),
                      subtitle: option == 'Arabic' || option == 'Urdu'
                          ? Text('RTL Layout', style: TextStyle(fontSize: 12))
                          : null,
                      onTap: () {
                        onSettingChanged("language", option);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showTextSizeDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Arabic Text Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => ListTile(
                    title: Text(option),
                    subtitle: Text(
                      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                      style: TextStyle(
                        fontSize: option == 'Small'
                            ? 12
                            : option == 'Medium'
                                ? 16
                                : option == 'Large'
                                    ? 20
                                    : 24,
                      ),
                    ),
                    onTap: () {
                      onSettingChanged("arabicTextSize", option);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
