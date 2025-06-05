import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/daily_quote_widget.dart';
import './widgets/islamic_events_widget.dart';
import './widgets/islamic_greeting_header_widget.dart';
import './widgets/next_prayer_hero_card_widget.dart';
import './widgets/prayer_times_list_widget.dart';
import './widgets/quick_access_buttons_widget.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isRefreshing = false;

  // Mock data for Islamic content
  final Map<String, dynamic> islamicData = {
    "hijriDate": "15 Jumada al-Awwal 1446",
    "gregorianDate": "December 16, 2024",
    "location": "Makkah, Saudi Arabia",
    "nextPrayer": {
      "name": "Maghrib",
      "time": "17:45",
      "timeRemaining": "2h 15m",
      "arabicName": "المغرب"
    },
    "prayerTimes": [
      {
        "name": "Fajr",
        "time": "05:30",
        "arabicName": "الفجر",
        "isNotificationOn": true
      },
      {
        "name": "Dhuhr",
        "time": "12:15",
        "arabicName": "الظهر",
        "isNotificationOn": true
      },
      {
        "name": "Asr",
        "time": "15:30",
        "arabicName": "العصر",
        "isNotificationOn": false
      },
      {
        "name": "Maghrib",
        "time": "17:45",
        "arabicName": "المغرب",
        "isNotificationOn": true
      },
      {
        "name": "Isha",
        "time": "19:15",
        "arabicName": "العشاء",
        "isNotificationOn": true
      }
    ],
    "dailyQuote": {
      "text":
          "And whoever relies upon Allah - then He is sufficient for him. Indeed, Allah will accomplish His purpose.",
      "reference": "Quran 65:3",
      "arabic":
          "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ ۚ إِنَّ اللَّهَ بَالِغُ أَمْرِهِ"
    },
    "islamicEvents": [
      {"name": "Mawlid an-Nabi", "date": "12 Rabi' al-Awwal", "daysLeft": 25},
      {"name": "Isra and Mi'raj", "date": "27 Rajab", "daysLeft": 95},
      {"name": "Ramadan Begins", "date": "1 Ramadan", "daysLeft": 125}
    ]
  };

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Dashboard - already here
        break;
      case 1:
        Navigator.pushNamed(context, '/hijri-calendar');
        break;
      case 2:
        // Qibla - placeholder
        break;
      case 3:
        // Quran - placeholder
        break;
      case 4:
        Navigator.pushNamed(context, '/settings-profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.primaryColor,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    IslamicGreetingHeaderWidget(
                      hijriDate: islamicData["hijriDate"] as String,
                      gregorianDate: islamicData["gregorianDate"] as String,
                      location: islamicData["location"] as String,
                    ),
                    SizedBox(height: 2.h),
                    NextPrayerHeroCardWidget(
                      nextPrayer:
                          islamicData["nextPrayer"] as Map<String, dynamic>,
                    ),
                    SizedBox(height: 3.h),
                    PrayerTimesListWidget(
                      prayerTimes: (islamicData["prayerTimes"] as List)
                          .map((prayer) => prayer as Map<String, dynamic>)
                          .toList(),
                    ),
                    SizedBox(height: 3.h),
                    DailyQuoteWidget(
                      quote: islamicData["dailyQuote"] as Map<String, dynamic>,
                    ),
                    SizedBox(height: 3.h),
                    IslamicEventsWidget(
                      events: (islamicData["islamicEvents"] as List)
                          .map((event) => event as Map<String, dynamic>)
                          .toList(),
                    ),
                    SizedBox(height: 3.h),
                    QuickAccessButtonsWidget(),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.primaryColor,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: _currentIndex == 0
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'calendar_today',
              color: _currentIndex == 1
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'explore',
              color: _currentIndex == 2
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Qibla',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'menu_book',
              color: _currentIndex == 3
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'more_horiz',
              color: _currentIndex == 4
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'More',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/islamic-events-notifications');
        },
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        foregroundColor: Colors.black,
        icon: CustomIconWidget(
          iconName: 'add_alert',
          color: Colors.black,
          size: 20,
        ),
        label: Text(
          'Add Reminder',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
