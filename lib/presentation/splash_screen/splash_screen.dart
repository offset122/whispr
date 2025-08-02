import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isInitializing = true;
  String _loadingText = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Hide system status bar for full-screen experience
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // Step 1: Generate anonymous user ID
      await _generateAnonymousUserId();

      // Step 2: Load content filters
      await _loadContentFilters();

      // Step 3: Fetch trending confessions
      await _fetchTrendingConfessions();

      // Step 4: Prepare cached data
      await _prepareCachedData();

      // Wait for animation to complete
      await Future.delayed(const Duration(milliseconds: 3000));

      // Navigate based on user status
      await _navigateToNextScreen();
    } catch (e) {
      // Handle initialization errors
      await _handleInitializationError();
    }
  }

  Future<void> _generateAnonymousUserId() async {
    setState(() {
      _loadingText = 'Creating anonymous identity...';
    });

    // Simulate anonymous user ID generation
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate random user ID in format User #123
    final userId = 'User #${DateTime.now().millisecondsSinceEpoch % 10000}';

    // Store in local storage (simulated)
    // In real implementation, this would use SharedPreferences
    debugPrint('Generated anonymous user ID: $userId');
  }

  Future<void> _loadContentFilters() async {
    setState(() {
      _loadingText = 'Loading content filters...';
    });

    await Future.delayed(const Duration(milliseconds: 400));

    // Load offensive content filtering rules
    // In real implementation, this would load from remote config
    debugPrint('Content filters loaded');
  }

  Future<void> _fetchTrendingConfessions() async {
    setState(() {
      _loadingText = 'Fetching trending confessions...';
    });

    await Future.delayed(const Duration(milliseconds: 600));

    // Fetch trending confessions for main feed
    // In real implementation, this would be an API call
    debugPrint('Trending confessions fetched');
  }

  Future<void> _prepareCachedData() async {
    setState(() {
      _loadingText = 'Preparing cached data...';
    });

    await Future.delayed(const Duration(milliseconds: 300));

    // Prepare cached data for offline functionality
    debugPrint('Cached data prepared');
  }

  Future<void> _navigateToNextScreen() async {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Check if user is first-time or returning
    final isFirstTime = await _checkIfFirstTimeUser();

    if (mounted) {
      if (isFirstTime) {
        // Navigate to onboarding (not implemented in this scope)
        Navigator.pushReplacementNamed(context, '/main-feed');
      } else {
        // Navigate directly to main feed
        Navigator.pushReplacementNamed(context, '/main-feed');
      }
    }
  }

  Future<bool> _checkIfFirstTimeUser() async {
    // In real implementation, check SharedPreferences
    // For now, assume returning user
    return false;
  }

  Future<void> _handleInitializationError() async {
    setState(() {
      _loadingText = 'Connection timeout';
      _isInitializing = false;
    });

    // Show retry option after 5 seconds
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      _showRetryDialog();
    }
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        title: Text(
          'Connection Error',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Unable to connect to Whispr servers. Please check your internet connection and try again.',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _retryInitialization();
            },
            child: Text(
              'Retry',
              style: TextStyle(color: AppTheme.accentPurple),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/main-feed');
            },
            child: Text(
              'Continue Offline',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _retryInitialization() {
    setState(() {
      _isInitializing = true;
      _loadingText = 'Retrying...';
    });

    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Restore system UI in case of early disposal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryDark,
                AppTheme.primaryDark.withValues(alpha: 0.8),
                AppTheme.secondaryDark.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo section with animations
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: _buildLogo(),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Loading section
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isInitializing) ...[
                      // Loading indicator
                      SizedBox(
                        width: 6.w,
                        height: 6.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.accentPurple.withValues(alpha: 0.8),
                          ),
                          backgroundColor:
                              AppTheme.textTertiary.withValues(alpha: 0.3),
                        ),
                      ),

                      SizedBox(height: 3.h),

                      // Loading text
                      Text(
                        _loadingText,
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    SizedBox(height: 4.h),

                    // App tagline
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'Your safe space for anonymous confessions',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textTertiary,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ghost/shadow themed logo
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppTheme.accentPurple.withValues(alpha: 0.3),
                AppTheme.accentPurple.withValues(alpha: 0.1),
                Colors.transparent,
              ],
              stops: const [0.3, 0.7, 1.0],
            ),
          ),
          child: Center(
            child: Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentPurple.withValues(alpha: 0.2),
                border: Border.all(
                  color: AppTheme.accentPurple.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'visibility_off',
                  color: AppTheme.accentPurple,
                  size: 8.w,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // App name
        Text(
          'Whispr',
          style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),

        SizedBox(height: 1.h),

        // Subtitle with ghost theme
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'lock_outline',
              color: AppTheme.supportTeal.withValues(alpha: 0.7),
              size: 4.w,
            ),
            SizedBox(width: 2.w),
            Text(
              'Anonymous & Secure',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.supportTeal.withValues(alpha: 0.8),
                letterSpacing: 0.8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
