import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreateEventBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onEventCreated;

  const CreateEventBottomSheet({
    super.key,
    required this.onEventCreated,
  });

  @override
  State<CreateEventBottomSheet> createState() => _CreateEventBottomSheetState();
}

class _CreateEventBottomSheetState extends State<CreateEventBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hijriDateController = TextEditingController();
  final _gregorianDateController = TextEditingController();

  String _selectedEventType = 'Personal Goal';
  String _selectedIcon = 'event';
  String _selectedPriority = 'medium';
  bool _isNotificationEnabled = true;

  final List<Map<String, String>> _eventTemplates = [
    {'name': 'Fasting Day', 'icon': 'restaurant', 'type': 'Recommended Fast'},
    {
      'name': 'Charity Reminder',
      'icon': 'volunteer_activism',
      'type': 'Personal Goal'
    },
    {'name': 'Study Session', 'icon': 'menu_book', 'type': 'Study Reminder'},
    {'name': 'Prayer Reminder', 'icon': 'mosque', 'type': 'Prayer Reminder'},
    {'name': 'Community Event', 'icon': 'groups', 'type': 'Community Event'},
    {
      'name': 'Religious Holiday',
      'icon': 'celebration',
      'type': 'Religious Holiday'
    },
  ];

  final List<Map<String, String>> _iconOptions = [
    {'name': 'Event', 'icon': 'event'},
    {'name': 'Star', 'icon': 'star'},
    {'name': 'Mosque', 'icon': 'mosque'},
    {'name': 'Book', 'icon': 'menu_book'},
    {'name': 'Heart', 'icon': 'favorite'},
    {'name': 'Celebration', 'icon': 'celebration'},
    {'name': 'Restaurant', 'icon': 'restaurant'},
    {'name': 'Volunteer', 'icon': 'volunteer_activism'},
    {'name': 'Groups', 'icon': 'groups'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hijriDateController.dispose();
    _gregorianDateController.dispose();
    super.dispose();
  }

  void _createEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'hijriDate': _hijriDateController.text,
        'gregorianDate': _gregorianDateController.text,
        'eventType': _selectedEventType,
        'icon': _selectedIcon,
        'isNotificationEnabled': _isNotificationEnabled,
        'priority': _selectedPriority,
        'category': 'personal',
        'significance': 'User-created event for personal Islamic practice.',
        'practices': ['Personal reflection', 'Prayer', 'Remembrance'],
      };

      widget.onEventCreated(newEvent);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Text(
                  'Create New Event',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Templates',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _eventTemplates.length,
                        itemBuilder: (context, index) {
                          final template = _eventTemplates[index];
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _titleController.text = template['name']!;
                                  _selectedIcon = template['icon']!;
                                  _selectedEventType = template['type']!;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme
                                        .lightTheme.colorScheme.outline
                                        .withValues(alpha: 0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    CustomIconWidget(
                                      iconName: template['icon']!,
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      size: 24,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      template['name']!,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Event Title',
                        hintText: 'Enter event title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter event description',
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _hijriDateController,
                            decoration: InputDecoration(
                              labelText: 'Hijri Date',
                              hintText: 'e.g., 15 Rajab 1446',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Hijri date';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _gregorianDateController,
                            decoration: InputDecoration(
                              labelText: 'Gregorian Date',
                              hintText: 'e.g., Jan 15, 2025',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Gregorian date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedEventType,
                      decoration: InputDecoration(
                        labelText: 'Event Type',
                      ),
                      items: [
                        'Personal Goal',
                        'Prayer Reminder',
                        'Study Reminder',
                        'Community Event',
                        'Religious Holiday',
                        'Recommended Fast',
                      ]
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEventType = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Select Icon',
                      style: AppTheme.lightTheme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _iconOptions.map((iconOption) {
                        final isSelected = _selectedIcon == iconOption['icon'];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIcon = iconOption['icon']!;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.lightTheme.colorScheme.primary
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.lightTheme.colorScheme.primary
                                    : AppTheme.lightTheme.colorScheme.outline
                                        .withValues(alpha: 0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomIconWidget(
                              iconName: iconOption['icon']!,
                              color: isSelected
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                              size: 24,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                      ),
                      items: [
                        {'value': 'low', 'label': 'Low Priority'},
                        {'value': 'medium', 'label': 'Medium Priority'},
                        {'value': 'high', 'label': 'High Priority'},
                      ]
                          .map((priority) => DropdownMenuItem(
                                value: priority['value'],
                                child: Text(priority['label']!),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      title: Text('Enable Notifications'),
                      subtitle: Text('Receive reminders for this event'),
                      value: _isNotificationEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isNotificationEnabled = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _createEvent,
                    child: Text('Create Event'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
