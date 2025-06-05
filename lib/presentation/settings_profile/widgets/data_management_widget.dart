import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class DataManagementWidget extends StatelessWidget {
  final Function(String) onAction;

  const DataManagementWidget({
    super.key,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Backup Data
          _buildActionTile(
            context: context,
            title: 'Backup Data',
            subtitle: 'Backup Islamic bookmarks and settings',
            icon: 'backup',
            onTap: () => onAction('backup'),
          ),

          Divider(height: 1),

          // Restore Data
          _buildActionTile(
            context: context,
            title: 'Restore Data',
            subtitle: 'Restore from previous backup',
            icon: 'restore',
            onTap: () => onAction('restore'),
          ),

          Divider(height: 1),

          // Download Quran
          _buildActionTile(
            context: context,
            title: 'Download Quran',
            subtitle: 'Download for offline access',
            icon: 'download',
            onTap: () => onAction('downloadQuran'),
          ),

          Divider(height: 1),

          // Clear Cache
          _buildActionTile(
            context: context,
            title: 'Clear Cache',
            subtitle: 'Free up storage space',
            icon: 'delete_sweep',
            onTap: () => onAction('clearCache'),
            isDestructive: true,
          ),

          Divider(height: 1),

          // Storage Usage
          _buildStorageUsage(context),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: isDestructive
            ? AppTheme.errorLight
            : AppTheme.lightTheme.colorScheme.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isDestructive ? AppTheme.errorLight : null,
            ),
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

  Widget _buildStorageUsage(BuildContext context) {
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
                iconName: 'storage',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Storage Usage',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildStorageItem(context, 'Quran Audio', '245 MB', 0.6),
          SizedBox(height: 8),
          _buildStorageItem(context, 'Bookmarks', '2.3 MB', 0.1),
          SizedBox(height: 8),
          _buildStorageItem(context, 'Cache', '15.7 MB', 0.2),
          SizedBox(height: 8),
          _buildStorageItem(context, 'Settings', '0.5 MB', 0.05),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Used',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '263.5 MB',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageItem(
      BuildContext context, String name, String size, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              size,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.withValues(alpha: 0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
