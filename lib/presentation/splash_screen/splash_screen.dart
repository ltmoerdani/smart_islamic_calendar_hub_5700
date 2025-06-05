import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/geometric_background_widget.dart';
import './widgets/islamic_logo_widget.dart';
import './widgets/loading_indicator_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _screenFadeAnimation;

  bool _isInitialized = false;
  String _loadingText = 'جاري التحميل';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _screenFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Simulate initialization tasks
      await Future.wait([
        _checkLocationPermissions(),
        _loadHijriCalendarData(),
        _fetchUserPreferences(),
        _prepareCachedQuranContent(),
      ]);

      setState(() {
        _isInitialized = true;
      });

      // Wait for minimum splash duration
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate based on user status
      await _navigateToNextScreen();
    } catch (e) {
      // Handle initialization errors
      setState(() {
        _loadingText = 'خطأ في التحميل';
      });

      // Retry after delay
      await Future.delayed(const Duration(seconds: 2));
      await _navigateToNextScreen();
    }
  }

  Future<void> _checkLocationPermissions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock location permission check
  }

  Future<void> _loadHijriCalendarData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Mock Hijri calendar data loading
  }

  Future<void> _fetchUserPreferences() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock user preferences fetching
  }

  Future<void> _prepareCachedQuranContent() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock Quran content preparation
  }

  Future<void> _navigateToNextScreen() async {
    await _fadeAnimationController.forward();

    if (!mounted) return;

    // Mock user status check
    final bool isNewUser = DateTime.now().millisecond % 2 == 0;

    if (isNewUser) {
      Navigator.pushReplacementNamed(context, '/onboarding-flow');
    } else {
      Navigator.pushReplacementNamed(context, '/main-dashboard');
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.lightTheme.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.primaryColor,
        body: AnimatedBuilder(
          animation: _screenFadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _screenFadeAnimation.value,
              child: SafeArea(
                child: Stack(
                  children: [
                    // Geometric background pattern
                    const GeometricBackgroundWidget(),

                    // Main content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Animated logo
                          AnimatedBuilder(
                            animation: _logoAnimationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _logoScaleAnimation.value,
                                child: Opacity(
                                  opacity: _logoFadeAnimation.value,
                                  child: const IslamicLogoWidget(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 48),

                          // Loading indicator and text
                          LoadingIndicatorWidget(
                            loadingText: _loadingText,
                            isInitialized: _isInitialized,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
