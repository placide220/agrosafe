import 'package:flutter/material.dart';
import '../features/auth/domain/entities/user_entity.dart';
import '../features/crop_incident/domain/entities/incident_entity.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'auth/welcome_page.dart';
import 'community_forum/ask_an_expert_page.dart';
import 'community_forum/community_forum_page.dart';
import 'community_forum/my_cooperative_page.dart';
import 'community_forum/well_being_check_in_page.dart';
import 'community_forum/women_farmers_circle_page.dart';
import 'crop_incident/add_edit_incident_page.dart';
import 'crop_incident/crop_advisory_page.dart';
import 'crop_incident/incident_detail_page.dart';
import 'crop_incident/incident_list_page.dart';
import 'main_navigation/high_contrast_home_view.dart';
import 'main_navigation/main_navigation_page.dart';
import 'main_navigation/voice_navigation_modal.dart';
import 'onboarding/onboarding_accessibility_page.dart';
import 'onboarding/onboarding_farm_page.dart';
import 'onboarding/onboarding_language_page.dart';
import 'onboarding/onboarding_name_page.dart';
import 'safety_misinformation/check_advice_page.dart';
import 'safety_misinformation/safety_scam_page.dart';
import 'settings_profile/settings_profile_page.dart';
import 'weather_calendar/weather_calendar_page.dart';
import 'weather_calendar/weather_forecast_detail_page.dart';

class AppScreensNavigator extends StatelessWidget {
  const AppScreensNavigator({super.key});

  static const sampleUser = UserEntity(
    uid: 'demo_123',
    email: 'claudine@agrosafe.rw',
    fullName: 'Claudine Uwimana',
    farmLocation: 'Musanze District (Northern Province)',
    role: 'Smallholder Farmer',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final screens = [
      _ScreenItem(
        title: '1. Welcome Landing Screen',
        subtitle: 'App introduction & brand tagline',
        category: 'Auth & Onboarding',
        icon: Icons.park_rounded,
        builder: (_) => const WelcomePage(),
      ),
      _ScreenItem(
        title: '2. Login Page',
        subtitle: 'Firebase email/password & guest access',
        category: 'Auth & Onboarding',
        icon: Icons.login_rounded,
        builder: (_) => const LoginPage(),
      ),
      _ScreenItem(
        title: '3. Register Page',
        subtitle: 'New farmer account creation',
        category: 'Auth & Onboarding',
        icon: Icons.person_add_rounded,
        builder: (_) => const RegisterPage(),
      ),
      _ScreenItem(
        title: '4. Onboarding (1/4): Language',
        subtitle: 'Kinyarwanda/English i18n & voice prompt',
        category: 'Auth & Onboarding',
        icon: Icons.language_rounded,
        builder: (_) => const OnboardingLanguagePage(),
      ),
      _ScreenItem(
        title: '5. Onboarding (2/4): Name',
        subtitle: 'Farmer profile registration step',
        category: 'Auth & Onboarding',
        icon: Icons.badge_rounded,
        builder: (_) => const OnboardingNamePage(),
      ),
      _ScreenItem(
        title: '6. Onboarding (3/4): Farm & District',
        subtitle: 'Musanze location & crop selection chips',
        category: 'Auth & Onboarding',
        icon: Icons.eco_rounded,
        builder: (_) => const OnboardingFarmPage(farmerName: 'Claudine'),
      ),
      _ScreenItem(
        title: '7. Onboarding (4/4): Accessibility',
        subtitle: 'High contrast & text size preferences',
        category: 'Auth & Onboarding',
        icon: Icons.accessibility_new_rounded,
        builder: (_) => const OnboardingAccessibilityPage(
          farmerName: 'Claudine',
          district: 'Musanze District',
        ),
      ),
      _ScreenItem(
        title: '8. Main Bottom Navigation Hub',
        subtitle: 'Central shell embedding 5 core modules',
        category: 'Core Navigation',
        icon: Icons.space_dashboard_rounded,
        builder: (_) => const MainNavigationPage(user: sampleUser),
      ),
      _ScreenItem(
        title: '9. Outdoor High-Contrast Home View',
        subtitle: '#000000 black background with #FFFF00 icons',
        category: 'Core Navigation',
        icon: Icons.contrast_rounded,
        builder: (navContext) => HighContrastHomeView(
          user: sampleUser,
          onExitHighContrast: () => Navigator.pop(navContext),
        ),
      ),
      _ScreenItem(
        title: '10. Voice Navigation Modal',
        subtitle: 'Audio speech recognition assistant',
        category: 'Core Navigation',
        icon: Icons.mic_rounded,
        builder: (_) => const VoiceNavigationModal(),
      ),
      _ScreenItem(
        title: '11. Weather & Planting Calendar Page',
        subtitle: 'Binary planting directives & forecast',
        category: 'Weather & Climate',
        icon: Icons.wb_sunny_rounded,
        builder: (_) => const WeatherCalendarPage(),
      ),
      _ScreenItem(
        title: '12. 7-Day Forecast Detail Page',
        subtitle: 'Microclimate rain timeline & soil moisture',
        category: 'Weather & Climate',
        icon: Icons.calendar_month_rounded,
        builder: (_) => const WeatherForecastDetailPage(),
      ),
      _ScreenItem(
        title: '13. Safety Scam Alert Board',
        subtitle: 'Counterfeit fertilizer alert & scam checker',
        category: 'Safety & Verification',
        icon: Icons.security_rounded,
        builder: (_) => const SafetyScamPage(),
      ),
      _ScreenItem(
        title: '14. MINAGRI Advice Verifier Page',
        subtitle: 'Official agricultural extension check',
        category: 'Safety & Verification',
        icon: Icons.verified_user_rounded,
        builder: (_) => const CheckAdvicePage(),
      ),
      _ScreenItem(
        title: '15. Crop Incident Outbreak List',
        subtitle: 'Pest outbreak Firestore CRUD list',
        category: 'Crop Incident Management',
        icon: Icons.bug_report_rounded,
        builder: (_) => const IncidentListPage(user: sampleUser),
      ),
      _ScreenItem(
        title: '16. Add / Edit Incident Form',
        subtitle: 'Create or update pest incident report',
        category: 'Crop Incident Management',
        icon: Icons.add_alert_rounded,
        builder: (_) => const AddEditIncidentPage(user: sampleUser),
      ),
      _ScreenItem(
        title: '17. Incident Detail View',
        subtitle: 'Threat status resolution & action items',
        category: 'Crop Incident Management',
        icon: Icons.info_outline_rounded,
        builder: (_) => IncidentDetailPage(
          user: sampleUser,
          incident: IncidentEntity(
            id: 'demo_inc_1',
            userId: 'demo_123',
            cropName: 'Irish Potatoes',
            issueType: 'Potato Late Blight',
            description: 'Fungal infection detected in Musanze plot.',
            severity: 'High',
            location: 'Musanze District',
            reportedAt: DateTime.now(),
            status: 'Under Review',
          ),
        ),
      ),
      _ScreenItem(
        title: '18. Crop Growth Stage Advisory Page',
        subtitle: 'Growth phase fertilizer & spraying tips',
        category: 'Crop Incident Management',
        icon: Icons.grass_rounded,
        builder: (_) => const CropAdvisoryPage(),
      ),
      _ScreenItem(
        title: '19. Community Forum Hub',
        subtitle: 'Farmer peer-to-peer discussion board',
        category: 'Community & Peer Support',
        icon: Icons.forum_rounded,
        builder: (_) => const CommunityForumPage(user: sampleUser),
      ),
      _ScreenItem(
        title: '20. Women Farmers Circle Page',
        subtitle: 'Bio-pesticide bulk buying & workshops',
        category: 'Community & Peer Support',
        icon: Icons.female_rounded,
        builder: (_) => const WomenFarmersCirclePage(),
      ),
      _ScreenItem(
        title: '21. My Cooperative Depot Page',
        subtitle: 'Seed stock tracking & depot updates',
        category: 'Community & Peer Support',
        icon: Icons.storefront_rounded,
        builder: (_) => const MyCooperativePage(),
      ),
      _ScreenItem(
        title: '22. Ask an Expert Agronomist Page',
        subtitle: 'Live Q&A with certified extension officers',
        category: 'Community & Peer Support',
        icon: Icons.school_rounded,
        builder: (_) => const AskAnExpertPage(),
      ),
      _ScreenItem(
        title: '23. Well-Being Check-in Page',
        subtitle: 'Farmer mental health & stress support',
        category: 'Community & Peer Support',
        icon: Icons.psychology_rounded,
        builder: (_) => const WellBeingCheckInPage(),
      ),
      _ScreenItem(
        title: '24. Settings & Profile Page',
        subtitle: 'Language toggle, high contrast & sign out',
        category: 'Settings & Profile',
        icon: Icons.settings_rounded,
        builder: (_) => const SettingsProfilePage(user: sampleUser),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroSafe Master Screen Directory'),
        backgroundColor: const Color(0xFF1E5620),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final screen = screens[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1E5620).withValues(alpha: 0.1),
                child: Icon(screen.icon, color: const Color(0xFF1E5620)),
              ),
              title: Text(
                screen.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(screen.subtitle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E5620).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      screen.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: screen.builder));
              },
            ),
          );
        },
      ),
    );
  }
}

class _ScreenItem {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final WidgetBuilder builder;

  _ScreenItem({
    required this.title,
    required this.subtitle,
    required String category,
    required this.icon,
    required this.builder,
  }) : category = category.toUpperCase();
}
