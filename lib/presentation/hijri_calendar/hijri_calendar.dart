import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/calendar_grid_widget.dart';
import './widgets/calendar_header_widget.dart';
import './widgets/date_detail_sheet_widget.dart';
import './widgets/event_creation_sheet_widget.dart';
import './widgets/month_options_sheet_widget.dart';

class HijriCalendarScreen extends StatefulWidget {
  const HijriCalendarScreen({super.key});

  @override
  State<HijriCalendarScreen> createState() => _HijriCalendarScreenState();
}

class _HijriCalendarScreenState extends State<HijriCalendarScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int _currentMonthIndex = 0;
  bool _isHijriPrimary = true;
  bool _isLoading = false;
  Map<String, dynamic>? _selectedDate;

  // Mock Hijri calendar data
  final List<Map<String, dynamic>> _hijriMonths = [
    {
      "monthName": "Muharram",
      "monthNumber": 1,
      "year": 1446,
      "gregorianMonth": "July",
      "gregorianYear": 2024,
      "days": _generateMonthDays(30, 1, 1446),
    },
    {
      "monthName": "Safar",
      "monthNumber": 2,
      "year": 1446,
      "gregorianMonth": "August",
      "gregorianYear": 2024,
      "days": _generateMonthDays(29, 2, 1446),
    },
    {
      "monthName": "Rabi' al-Awwal",
      "monthNumber": 3,
      "year": 1446,
      "gregorianMonth": "September",
      "gregorianYear": 2024,
      "days": _generateMonthDays(30, 3, 1446),
    },
    {
      "monthName": "Rabi' al-Thani",
      "monthNumber": 4,
      "year": 1446,
      "gregorianMonth": "October",
      "gregorianYear": 2024,
      "days": _generateMonthDays(29, 4, 1446),
    },
    {
      "monthName": "Jumada al-Awwal",
      "monthNumber": 5,
      "year": 1446,
      "gregorianMonth": "November",
      "gregorianYear": 2024,
      "days": _generateMonthDays(30, 5, 1446),
    },
    {
      "monthName": "Jumada al-Thani",
      "monthNumber": 6,
      "year": 1446,
      "gregorianMonth": "December",
      "gregorianYear": 2024,
      "days": _generateMonthDays(29, 6, 1446),
    },
  ];

  static List<Map<String, dynamic>> _generateMonthDays(
      int totalDays, int month, int year) {
    final List<Map<String, dynamic>> days = [];
    final DateTime now = DateTime.now();
    final int todayHijri = 15; // Mock today's Hijri date

    for (int i = 1; i <= totalDays; i++) {
      final bool isToday = i == todayHijri && month == 1;
      final bool hasEvent = [1, 10, 12, 15, 27].contains(i);
      final String eventType = i == 1
          ? "holiday"
          : i == 10
              ? "religious"
              : i == 12
                  ? "fasting"
                  : i == 15
                      ? "prayer"
                      : "community";

      days.add({
        "hijriDay": i,
        "gregorianDay": i + 5, // Mock conversion
        "isToday": isToday,
        "hasEvent": hasEvent,
        "eventType": eventType,
        "moonPhase": _getMoonPhase(i),
        "events": hasEvent ? _getEventsForDay(i, eventType) : [],
        "islamicSignificance": _getIslamicSignificance(i, month),
      });
    }
    return days;
  }

  static String _getMoonPhase(int day) {
    if (day <= 7) return "new_moon";
    if (day <= 14) return "first_quarter";
    if (day <= 21) return "full_moon";
    return "last_quarter";
  }

  static List<Map<String, dynamic>> _getEventsForDay(int day, String type) {
    final Map<int, List<Map<String, dynamic>>> eventMap = {
      1: [
        {
          "title": "Islamic New Year",
          "type": "holiday",
          "description": "Beginning of the Islamic calendar year"
        }
      ],
      10: [
        {
          "title": "Day of Ashura",
          "type": "religious",
          "description": "Significant day of fasting and remembrance"
        }
      ],
      12: [
        {
          "title": "Sunnah Fasting",
          "type": "fasting",
          "description": "Recommended fasting day"
        }
      ],
      15: [
        {
          "title": "Night Prayer",
          "type": "prayer",
          "description": "Special night prayer gathering"
        }
      ],
      27: [
        {
          "title": "Community Iftar",
          "type": "community",
          "description": "Community gathering for breaking fast"
        }
      ],
    };
    return eventMap[day] ?? [];
  }

  static String _getIslamicSignificance(int day, int month) {
    if (month == 1 && day == 1) return "Islamic New Year - A blessed beginning";
    if (month == 1 && day == 10) {
      return "Day of Ashura - Day of fasting and reflection";
    }
    if (day == 15) return "Middle of the month - Blessed night";
    return "Regular Islamic day with five daily prayers";
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentMonthIndex);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onDateTapped(Map<String, dynamic> dateData) {
    setState(() {
      _selectedDate = dateData;
    });
    _showDateDetailSheet();
  }

  void _onDateLongPressed(Map<String, dynamic> dateData) {
    setState(() {
      _selectedDate = dateData;
    });
    _showEventCreationSheet();
  }

  void _showDateDetailSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DateDetailSheetWidget(
        dateData: _selectedDate!,
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  void _showEventCreationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EventCreationSheetWidget(
        dateData: _selectedDate!,
        onEventCreated: (event) {
          Navigator.pop(context);
          _showSuccessMessage("Event created successfully");
        },
      ),
    );
  }

  void _showMonthOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MonthOptionsSheetWidget(
        onOptionSelected: (option) {
          Navigator.pop(context);
          _handleMonthOption(option);
        },
      ),
    );
  }

  void _handleMonthOption(String option) {
    switch (option) {
      case 'events_only':
        _showSuccessMessage("Showing events only");
        break;
      case 'moon_phases':
        _showSuccessMessage("Showing moon phases");
        break;
      case 'fasting_days':
        _showSuccessMessage("Showing fasting days");
        break;
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _refreshCalendar() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    _showSuccessMessage("Calendar data refreshed");
  }

  void _toggleCalendarMode() {
    setState(() {
      _isHijriPrimary = !_isHijriPrimary;
    });
    _fadeController.reset();
    _fadeController.forward();
  }

  void _navigateToSearch() {
    _showSuccessMessage("Islamic date converter opened");
  }

  void _createNewEvent() {
    final DateTime now = DateTime.now();
    final Map<String, dynamic> todayData = {
      "hijriDay": 15,
      "gregorianDay": 20,
      "isToday": true,
      "hasEvent": false,
      "eventType": "custom",
      "moonPhase": "full_moon",
      "events": [],
      "islamicSignificance": "Today - Create your event",
    };

    setState(() {
      _selectedDate = todayData;
    });
    _showEventCreationSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CalendarHeaderWidget(
              currentMonth: _hijriMonths[_currentMonthIndex],
              isHijriPrimary: _isHijriPrimary,
              onToggleMode: _toggleCalendarMode,
              onSearchTapped: _navigateToSearch,
              onMonthChanged: (direction) {
                if (direction == 'previous' && _currentMonthIndex > 0) {
                  setState(() {
                    _currentMonthIndex--;
                  });
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else if (direction == 'next' &&
                    _currentMonthIndex < _hijriMonths.length - 1) {
                  setState(() {
                    _currentMonthIndex++;
                  });
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCalendar,
                color: AppTheme.lightTheme.colorScheme.primary,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentMonthIndex = index;
                      });
                    },
                    itemCount: _hijriMonths.length,
                    itemBuilder: (context, index) {
                      return CalendarGridWidget(
                        monthData: _hijriMonths[index],
                        isHijriPrimary: _isHijriPrimary,
                        onDateTapped: _onDateTapped,
                        onDateLongPressed: _onDateLongPressed,
                        isLoading: _isLoading,
                      );
                    },
                  ),
                ),
              ),
            ),
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy < -500) {
                  _showMonthOptionsSheet();
                }
              },
              child: BottomNavigationWidget(
                currentIndex: 1, // Calendar tab active
                onTabChanged: (index) {
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, '/main-dashboard');
                      break;
                    case 1:
                      // Already on calendar
                      break;
                    case 2:
                      Navigator.pushNamed(
                          context, '/islamic-events-notifications');
                      break;
                    case 3:
                      Navigator.pushNamed(context, '/settings-profile');
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewEvent,
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }
}
