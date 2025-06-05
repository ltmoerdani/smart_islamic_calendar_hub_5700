import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/hijri_calendar/hijri_calendar.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/main_dashboard/main_dashboard.dart';
import '../presentation/islamic_events_notifications/islamic_events_notifications.dart';
import '../presentation/settings_profile/settings_profile.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String mainDashboard = '/main-dashboard';
  static const String hijriCalendar = '/hijri-calendar';
  static const String islamicEventsNotifications =
      '/islamic-events-notifications';
  static const String settingsProfile = '/settings-profile';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    hijriCalendar: (context) => const HijriCalendarScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    mainDashboard: (context) => const MainDashboard(),
    islamicEventsNotifications: (context) =>
        const IslamicEventsNotifications(),
    settingsProfile: (context) => const SettingsProfile(),
  };
}