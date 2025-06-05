import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EventCreationSheetWidget extends StatefulWidget {
  final Map<String, dynamic> dateData;
  final Function(Map<String, dynamic>) onEventCreated;

  const EventCreationSheetWidget({
    super.key,
    required this.dateData,
    required this.onEventCreated,
  });

  @override
  State<EventCreationSheetWidget> createState() =>
      _EventCreationSheetWidgetState();
}

class _EventCreationSheetWidgetState extends State<EventCreationSheetWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedEventType = 'personal';
  String _selectedTemplate = '';

  final List<Map<String, dynamic>> _eventTemplates = [
    {
      "id": "prayer_gathering",
      "title": "Prayer Gathering",
      "type": "prayer",
      "description": "Community prayer gathering at the mosque",
      "icon": "mosque",
    },
    {
      "id": "quran_study",
      "title": "Quran Study Circle",
      "type": "religious",
      "description": "Weekly Quran study and discussion session",
      "icon": "menu_book",
    },
    {
      "id": "iftar_invitation",
      "title": "Iftar Invitation",
      "type": "community",
      "description": "Breaking fast together with family and friends",
      "icon": "restaurant",
    },
    {
      "id": "charity_drive",
      "title": "Charity Drive",
      "type": "community",
      "description": "Organizing charity collection for those in need",
      "icon": "volunteer_activism",
    },
    {
      "id": "islamic_lecture",
      "title": "Islamic Lecture",
      "type": "religious",
      "description": "Educational lecture on Islamic topics",
      "icon": "school",
    },
  ];

  final List<Map<String, dynamic>> _eventTypes = [
    {"value": "personal", "label": "Personal", "color": "primary"},
    {"value": "prayer", "label": "Prayer", "color": "tertiary"},
    {"value": "religious", "label": "Religious", "color": "primary"},
    {"value": "community", "label": "Community", "color": "secondary"},
    {"value": "fasting", "label": "Fasting", "color": "secondary"},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectTemplate(Map<String, dynamic> template) {
    setState(() {
      _selectedTemplate = template['id'] as String;
      _titleController.text = template['title'] as String;
      _descriptionController.text = template['description'] as String;
      _selectedEventType = template['type'] as String;
    });
  }

  void _createEvent() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an event title'),
          backgroundColor: AppTheme.lightTheme.colorScheme.error,
        ),
      );
      return;
    }

    final Map<String, dynamic> newEvent = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "type": _selectedEventType,
      "date": widget.dateData,
      "template": _selectedTemplate,
      "createdAt": DateTime.now().toIso8601String(),
    };

    widget.onEventCreated(newEvent);
  }

  Color _getTypeColor(String colorName) {
    switch (colorName) {
      case 'primary':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'secondary':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'tertiary':
        return AppTheme.lightTheme.colorScheme.tertiary;
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int hijriDay = widget.dateData['hijriDay'] as int? ?? 0;
    final int gregorianDay = widget.dateData['gregorianDay'] as int? ?? 0;

    return Container(
      height: 85.h,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Event',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hijri: $hijriDay | Gregorian: $gregorianDay',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                  // Event templates
                  Text(
                    'Quick Templates',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  SizedBox(
                    height: 12.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _eventTemplates.length,
                      itemBuilder: (context, index) {
                        final template = _eventTemplates[index];
                        final bool isSelected =
                            _selectedTemplate == template['id'];

                        return GestureDetector(
                          onTap: () => _selectTemplate(template),
                          child: Container(
                            width: 25.w,
                            margin: EdgeInsets.only(right: 3.w),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.lightTheme.colorScheme.primary
                                      .withValues(alpha: 0.1)
                                  : AppTheme.lightTheme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.lightTheme.colorScheme.primary
                                    : AppTheme.lightTheme.colorScheme.outline
                                        .withValues(alpha: 0.3),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconWidget(
                                  iconName: template['icon'] as String,
                                  color: isSelected
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme
                                          .lightTheme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                  size: 24,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  template['title'] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: isSelected
                                        ? AppTheme
                                            .lightTheme.colorScheme.primary
                                        : AppTheme
                                            .lightTheme.colorScheme.onSurface,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Event title
                  Text(
                    'Event Title',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter event title',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'title',
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Event type
                  Text(
                    'Event Type',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _eventTypes.map((type) {
                      final bool isSelected =
                          _selectedEventType == type['value'];
                      final Color typeColor =
                          _getTypeColor(type['color'] as String);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedEventType = type['value'] as String;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? typeColor.withValues(alpha: 0.2)
                                : AppTheme.lightTheme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? typeColor
                                  : AppTheme.lightTheme.colorScheme.outline
                                      .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            type['label'] as String,
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: isSelected
                                  ? typeColor
                                  : AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 3.h),

                  // Event description
                  Text(
                    'Description (Optional)',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter event description',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 3.w),
                        child: CustomIconWidget(
                          iconName: 'description',
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),

          // Create button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createEvent,
                child: Text('Create Event'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
