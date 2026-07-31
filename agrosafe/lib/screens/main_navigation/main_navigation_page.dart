import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../community_forum/community_forum_page.dart';
import '../safety_misinformation/safety_scam_page.dart';
import '../settings_profile/accessibility_settings_page.dart';
import '../weather_calendar/weather_forecast_detail_page.dart';
import 'home_hub_view.dart';

class MainNavigationPage extends StatefulWidget {
  final UserEntity user;

  const MainNavigationPage({super.key, required this.user});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final isRw = langCode == 'rw';

    final pages = [
      HomeHubView(user: widget.user, onNavigateTab: _navigateToTab),
      const WeatherForecastDetailPage(),
      const SafetyScamPage(),
      CommunityForumPage(user: widget.user),
      const AccessibilitySettingsPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF1E5620).withValues(alpha: 0.12),
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: Color(0xFF1E5620),
            ),
            label: isRw ? 'Ahabanza' : 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.cloud_outlined),
            selectedIcon: const Icon(
              Icons.cloud_rounded,
              color: Color(0xFF1E5620),
            ),
            label: isRw ? 'Ikirere' : 'Weather',
          ),
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(
              Icons.shield_rounded,
              color: Color(0xFF1E5620),
            ),
            label: isRw ? 'Ubutekamutwe' : 'Safety',
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline_rounded),
            selectedIcon: const Icon(
              Icons.people_rounded,
              color: Color(0xFF1E5620),
            ),
            label: isRw ? 'Umuryango' : 'Community',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(
              Icons.settings_rounded,
              color: Color(0xFF1E5620),
            ),
            label: isRw ? 'Igenamiterere' : 'Settings',
          ),
        ],
      ),
    );
  }
}
