import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/onboarding_page_widget.dart';
import './widgets/page_indicator_widget.dart';
import './widgets/permission_request_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Prayer Time Notifications",
      "description":
          "Never miss your daily prayers with accurate, location-based prayer time notifications and beautiful mosque imagery to inspire your spiritual journey.",
      "imageUrl":
          "https://images.pexels.com/photos/8728380/pexels-photo-8728380.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "pattern": "prayer_pattern"
    },
    {
      "title": "Hijri Calendar",
      "description":
          "Stay connected with Islamic dates and lunar calendar. Track important Islamic events, holidays, and religious observances throughout the year.",
      "imageUrl":
          "https://images.pexels.com/photos/8728382/pexels-photo-8728382.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "pattern": "calendar_pattern"
    },
    {
      "title": "Qibla Finder",
      "description":
          "Find the accurate direction to Mecca from anywhere in the world with our precise compass visualization and GPS-based Qibla finder.",
      "imageUrl":
          "https://images.pexels.com/photos/8728379/pexels-photo-8728379.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "pattern": "compass_pattern"
    }
  ];

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _requestPermissionsAndNavigate() async {
    // Show permission request dialog
    bool? permissionsGranted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionRequestWidget(),
    );

    if (permissionsGranted == true) {
      // Navigate to main dashboard
      Navigator.pushReplacementNamed(context, '/main-dashboard');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main PageView
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _totalPages,
              itemBuilder: (context, index) {
                if (index < _onboardingData.length) {
                  return OnboardingPageWidget(
                    title: _onboardingData[index]["title"],
                    description: _onboardingData[index]["description"],
                    imageUrl: _onboardingData[index]["imageUrl"],
                    pattern: _onboardingData[index]["pattern"],
                  );
                } else {
                  // Permission request page
                  return _buildPermissionPage();
                }
              },
            ),

            // Skip button (top-right)
            if (_currentPage < _totalPages - 1)
              Positioned(
                top: 16,
                right: 16,
                child: TextButton(
                  onPressed: _skipToEnd,
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.lightTheme.colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    'Skip',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // Bottom navigation area
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Page indicators
                    PageIndicatorWidget(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                    ),

                    SizedBox(height: 24),

                    // Navigation button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _currentPage == _totalPages - 1
                            ? _requestPermissionsAndNavigate
                            : _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.primary,
                          foregroundColor:
                              AppTheme.lightTheme.colorScheme.onPrimary,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _totalPages - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color:
                                    AppTheme.lightTheme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (_currentPage < _totalPages - 1) ...[
                              SizedBox(width: 8),
                              CustomIconWidget(
                                iconName: 'arrow_forward',
                                color:
                                    AppTheme.lightTheme.colorScheme.onPrimary,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionPage() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Islamic geometric pattern background
          Container(
            width: 80.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  AppTheme.lightTheme.colorScheme.secondary
                      .withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'security',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 80,
                  ),
                  SizedBox(height: 16),
                  CustomIconWidget(
                    iconName: 'location_on',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  CustomIconWidget(
                    iconName: 'notifications',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 32),

          Text(
            'Essential Permissions',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          Text(
            'To provide you with accurate prayer times and timely Islamic reminders, we need access to your location and notification permissions. Your privacy is our priority.',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24),

          // Permission items
          _buildPermissionItem(
            icon: 'location_on',
            title: 'Location Access',
            description: 'For accurate prayer times based on your location',
          ),

          SizedBox(height: 16),

          _buildPermissionItem(
            icon: 'notifications',
            title: 'Notifications',
            description: 'For daily prayer reminders and Islamic events',
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: icon,
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
                  title,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
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
