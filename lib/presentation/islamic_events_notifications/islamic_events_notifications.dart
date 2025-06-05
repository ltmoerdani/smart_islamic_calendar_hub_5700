import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/create_event_bottom_sheet.dart';
import './widgets/event_card_widget.dart';
import './widgets/event_filter_widget.dart';
import './widgets/islamic_month_header_widget.dart';

class IslamicEventsNotifications extends StatefulWidget {
  const IslamicEventsNotifications({super.key});

  @override
  State<IslamicEventsNotifications> createState() =>
      _IslamicEventsNotificationsState();
}

class _IslamicEventsNotificationsState extends State<IslamicEventsNotifications>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All Events';
  bool _isSearching = false;
  late TabController _tabController;

  final List<Map<String, dynamic>> _islamicEvents = [
    {
      "id": 1,
      "title": "Laylat al-Qadr",
      "hijriDate": "27 Ramadan 1446",
      "gregorianDate": "March 28, 2025",
      "eventType": "Religious Holiday",
      "icon": "star",
      "isNotificationEnabled": true,
      "description":
          "The Night of Power, believed to be the night when the Quran was first revealed to Prophet Muhammad (PBUH).",
      "significance":
          "This night is better than a thousand months. Muslims engage in intensive worship, prayer, and Quran recitation.",
      "practices": ["Night prayers", "Quran recitation", "Dhikr", "Charity"],
      "verse":
          "Indeed, We sent the Qur'an down during the Night of Decree. And what can make you know what is the Night of Decree? The Night of Decree is better than a thousand months.",
      "verseReference": "Quran 97:1-3",
      "category": "holiday",
      "priority": "high"
    },
    {
      "id": 2,
      "title": "Eid al-Fitr",
      "hijriDate": "1 Shawwal 1446",
      "gregorianDate": "March 31, 2025",
      "eventType": "Major Holiday",
      "icon": "celebration",
      "isNotificationEnabled": true,
      "description":
          "Festival of Breaking the Fast, marking the end of Ramadan.",
      "significance":
          "A joyous celebration after completing the month of fasting, featuring special prayers and community gatherings.",
      "practices": [
        "Eid prayers",
        "Zakat al-Fitr",
        "Family gatherings",
        "Gift giving"
      ],
      "verse":
          "And it is He who created the heavens and earth in truth. And the day He says, 'Be,' and it is, His word is the truth.",
      "verseReference": "Quran 6:73",
      "category": "holiday",
      "priority": "high"
    },
    {
      "id": 3,
      "title": "Friday Prayer Reminder",
      "hijriDate": "Every Friday",
      "gregorianDate": "Weekly",
      "eventType": "Prayer Reminder",
      "icon": "mosque",
      "isNotificationEnabled": true,
      "description": "Weekly congregational prayer obligation for Muslim men.",
      "significance":
          "The most important prayer of the week, bringing the community together for worship and spiritual reflection.",
      "practices": [
        "Ghusl (ritual bath)",
        "Early arrival",
        "Listening to Khutbah",
        "Congregational prayer"
      ],
      "verse":
          "O you who believe! When the call is proclaimed for prayer on Friday, hasten earnestly to the remembrance of Allah.",
      "verseReference": "Quran 62:9",
      "category": "prayer",
      "priority": "medium"
    },
    {
      "id": 4,
      "title": "Charity Goal - \$500",
      "hijriDate": "15 Rajab 1446",
      "gregorianDate": "January 15, 2025",
      "eventType": "Personal Goal",
      "icon": "volunteer_activism",
      "isNotificationEnabled": true,
      "description": "Monthly charity goal to help those in need.",
      "significance":
          "Fulfilling the obligation of giving and purifying wealth through charitable acts.",
      "practices": [
        "Research worthy causes",
        "Calculate Zakat",
        "Anonymous giving",
        "Regular donations"
      ],
      "verse":
          "The example of those who spend their wealth in the way of Allah is like a seed which grows seven spikes.",
      "verseReference": "Quran 2:261",
      "category": "personal",
      "priority": "medium"
    },
    {
      "id": 5,
      "title": "Quran Study Session",
      "hijriDate": "Every Sunday",
      "gregorianDate": "Weekly",
      "eventType": "Study Reminder",
      "icon": "menu_book",
      "isNotificationEnabled": true,
      "description": "Weekly Quran study and reflection session.",
      "significance":
          "Deepening understanding of Islamic teachings and connecting with the divine message.",
      "practices": [
        "Tafsir reading",
        "Arabic study",
        "Reflection",
        "Note taking"
      ],
      "verse":
          "And We have certainly made the Qur'an easy for remembrance, so is there any who will remember?",
      "verseReference": "Quran 54:17",
      "category": "study",
      "priority": "low"
    },
    {
      "id": 6,
      "title": "Ashura Fast",
      "hijriDate": "10 Muharram 1446",
      "gregorianDate": "July 16, 2024",
      "eventType": "Recommended Fast",
      "icon": "restaurant",
      "isNotificationEnabled": true,
      "description": "Recommended fast on the Day of Ashura.",
      "significance":
          "Commemorating the day Allah saved Moses and the Israelites from Pharaoh.",
      "practices": [
        "Fasting",
        "Extra prayers",
        "Charity",
        "Remembrance of Allah"
      ],
      "verse":
          "And whoever relies upon Allah - then He is sufficient for him. Indeed, Allah will accomplish His purpose.",
      "verseReference": "Quran 65:3",
      "category": "fast",
      "priority": "medium"
    }
  ];

  List<Map<String, dynamic>> get _filteredEvents {
    List<Map<String, dynamic>> filtered = _islamicEvents;

    if (_selectedFilter != 'All Events') {
      switch (_selectedFilter) {
        case 'Holidays Only':
          filtered = filtered
              .where((event) => event['category'] == 'holiday')
              .toList();
          break;
        case 'Personal Reminders':
          filtered = filtered
              .where((event) => event['category'] == 'personal')
              .toList();
          break;
        case 'Community Events':
          filtered = filtered
              .where((event) => event['category'] == 'community')
              .toList();
          break;
        case 'Prayer Reminders':
          filtered =
              filtered.where((event) => event['category'] == 'prayer').toList();
          break;
      }
    }

    if (_searchController.text.isNotEmpty) {
      final searchTerm = _searchController.text.toLowerCase();
      filtered = filtered.where((event) {
        return (event['title'] as String).toLowerCase().contains(searchTerm) ||
            (event['description'] as String)
                .toLowerCase()
                .contains(searchTerm) ||
            (event['hijriDate'] as String).toLowerCase().contains(searchTerm);
      }).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEventDetailsSheet(event),
    );
  }

  void _showCreateEventSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateEventBottomSheet(
        onEventCreated: (newEvent) {
          setState(() {
            _islamicEvents.add(newEvent);
          });
        },
      ),
    );
  }

  Widget _buildEventDetailsSheet(Map<String, dynamic> event) {
    return Container(
      height: 85.h,
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomIconWidget(
                          iconName: event['icon'],
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'],
                              style:
                                  AppTheme.lightTheme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: 4),
                            Text(
                              event['eventType'],
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildDetailSection('Date Information', [
                    _buildDetailRow('Hijri Date', event['hijriDate']),
                    _buildDetailRow('Gregorian Date', event['gregorianDate']),
                  ]),
                  SizedBox(height: 20),
                  _buildDetailSection('Description', [
                    Text(
                      event['description'],
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                  ]),
                  SizedBox(height: 20),
                  _buildDetailSection('Islamic Significance', [
                    Text(
                      event['significance'],
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                  ]),
                  if (event['practices'] != null) ...[
                    SizedBox(height: 20),
                    _buildDetailSection('Traditional Practices', [
                      ...(event['practices'] as List).map(
                        (practice) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'check_circle',
                                color: AppTheme.lightTheme.colorScheme.primary,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                practice,
                                style: AppTheme.lightTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ],
                  if (event['verse'] != null) ...[
                    SizedBox(height: 20),
                    _buildDetailSection('Related Quranic Verse', [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['verse'],
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '- ${event['verseReference']}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CustomIconWidget(
                            iconName: 'edit',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 20,
                          ),
                          label: Text('Edit Event'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CustomIconWidget(
                            iconName: 'share',
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            size: 20,
                          ),
                          label: Text('Share'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(': '),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshEvents() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // Simulate refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Islamic Events'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings-profile');
            },
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 24,
            ),
          ),
        ],
        bottom: _isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search events, dates, or terms...',
                      prefixIcon: CustomIconWidget(
                        iconName: 'search',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: CustomIconWidget(
                                iconName: 'clear',
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              )
            : null,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: Column(
          children: [
            IslamicMonthHeaderWidget(),
            EventFilterWidget(
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
            Expanded(
              child: _filteredEvents.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'event_note',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No events found',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filter',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = _filteredEvents[index];
                        return EventCardWidget(
                          event: event,
                          onTap: () => _showEventDetails(event),
                          onNotificationToggle: (isEnabled) {
                            setState(() {
                              event['isNotificationEnabled'] = isEnabled;
                            });
                          },
                          onEdit: () {
                            // Handle edit
                          },
                          onDelete: () {
                            setState(() {
                              _islamicEvents
                                  .removeWhere((e) => e['id'] == event['id']);
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateEventSheet,
        icon: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor!,
          size: 24,
        ),
        label: Text('New Event'),
      ),
    );
  }
}
