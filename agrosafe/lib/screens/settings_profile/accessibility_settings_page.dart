import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../auth/login_page.dart';
import '../main_navigation/voice_navigation_modal.dart';

class AccessibilitySettingsPage extends StatefulWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  State<AccessibilitySettingsPage> createState() =>
      _AccessibilitySettingsPageState();
}

class _AccessibilitySettingsPageState extends State<AccessibilitySettingsPage> {
  bool _voiceGuidance = true;
  bool _largeText = false;
  bool _highContrast = false;
  String _selectedLang = 'rw';

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();
    final langCode = settingsCubit.state.settings.languageCode;
    final isRw = langCode == 'rw';
    _selectedLang = langCode;

    return Scaffold(
      appBar: AppBar(
        // Only show a back arrow when this screen was pushed (not as a tab).
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
        title: Text(isRw ? 'Igenamiterere' : 'Accessibility Settings'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF1E5620),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preference 1: Voice Guidance
            _buildPreferenceToggleCard(
              icon: Icons.volume_up_outlined,
              title: isRw ? 'Inyigisho z’Ijwi' : 'Voice Guidance',
              subtitle: isRw
                  ? 'Soma ibiri ku nyandiko mu buryo bw’ijwi'
                  : 'Read out screen content automatically',
              value: _voiceGuidance,
              onChanged: (val) {
                setState(() {
                  _voiceGuidance = val;
                });
              },
            ),
            const SizedBox(height: 14),

            // Preference 2: Large Text Mode
            _buildPreferenceToggleCard(
              icon: Icons.text_fields_rounded,
              title: isRw ? 'Inyandiko Nini' : 'Large Text Mode',
              subtitle: isRw
                  ? 'Gukurana inyandiko kugira ngo isomeke neza'
                  : 'Increase font size for easier reading',
              value: _largeText,
              onChanged: (val) {
                setState(() {
                  _largeText = val;
                });
              },
            ),
            const SizedBox(height: 14),

            // Preference 3: High Contrast Mode
            _buildPreferenceToggleCard(
              icon: Icons.contrast_rounded,
              title: isRw ? 'Amabara Akeneye Ku bona' : 'High Contrast Mode',
              subtitle: isRw
                  ? 'Koresha ishusho y’umukara n’inyandiko y’umuhondo'
                  : 'Use dark background with high visibility yellow text',
              value: _highContrast,
              onChanged: (val) {
                setState(() {
                  _highContrast = val;
                });
                settingsCubit.toggleHighContrast(val);
              },
            ),
            const SizedBox(height: 28),

            // Audio Language Section Header
            Text(
              isRw ? 'Ururimi rw’Ijwi' : 'Audio Language',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),

            // Language Card 1: Kinyarwanda
            _buildAudioLangCard(
              flagText: '🇷🇼',
              title: 'Kinyarwanda',
              subtitle: 'Ikinyarwanda',
              isSelected: _selectedLang == 'rw',
              onTap: () {
                setState(() {
                  _selectedLang = 'rw';
                });
                settingsCubit.setLanguageCode('rw');
              },
            ),
            const SizedBox(height: 12),

            // Language Card 2: English
            _buildAudioLangCard(
              flagText: '🇬🇧',
              title: 'English',
              subtitle: 'English',
              isSelected: _selectedLang == 'en',
              onTap: () {
                setState(() {
                  _selectedLang = 'en';
                });
                settingsCubit.setLanguageCode('en');
              },
            ),
            const SizedBox(height: 28),

            // Test Voice Assistant Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5620),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const VoiceNavigationModal(),
                    ),
                  );
                },
                icon: const Icon(Icons.volume_up_rounded, size: 22),
                label: Text(
                  isRw ? 'Gerageza Ubwumvi bw’Ijwi' : 'Test Voice Assistant',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sign Out / Log Out Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthSignOutSubmitted());
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: Text(
                  isRw ? 'Sohoka mu Konti' : 'Sign Out / Log Out',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceToggleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E5620).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF1E5620), size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF1E5620),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAudioLangCard({
    required String flagText,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F9F3) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1E5620)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flagText, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E5620),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
