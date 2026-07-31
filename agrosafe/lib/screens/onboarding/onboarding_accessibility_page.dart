import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/main_navigation_page.dart';

class OnboardingAccessibilityPage extends StatefulWidget {
  final String farmerName;
  final String district;

  const OnboardingAccessibilityPage({
    super.key,
    required this.farmerName,
    required this.district,
  });

  @override
  State<OnboardingAccessibilityPage> createState() =>
      _OnboardingAccessibilityPageState();
}

class _OnboardingAccessibilityPageState
    extends State<OnboardingAccessibilityPage> {
  bool _enableVoice = true;
  bool _enableLargeText = false;
  bool _enableHighContrast = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('AgroSafe'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                color: Color(0xFF1E5620),
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Segmented Progress Bar (3 steps: green, green, yellow)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5620),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5620),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'How would you like to use the app?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              const Text(
                'Customize AgroSafe to fit your needs for better accessibility in the field.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Preference Card 1: Voice Guidance
              _buildPrefCard(
                icon: Icons.record_voice_over_outlined,
                title: 'Voice Guidance',
                subtitle:
                    'Hear weather updates and safety alerts read aloud automatically.',
                value: _enableVoice,
                onChanged: (val) => setState(() => _enableVoice = val),
              ),
              const SizedBox(height: 14),

              // Preference Card 2: Large Text
              _buildPrefCard(
                icon: Icons.text_fields_rounded,
                title: 'Large Text',
                subtitle:
                    'Increase font size for easier reading in direct sunlight.',
                value: _enableLargeText,
                onChanged: (val) => setState(() => _enableLargeText = val),
              ),
              const SizedBox(height: 14),

              // Preference Card 3: High Contrast
              _buildPrefCard(
                icon: Icons.contrast_rounded,
                title: 'High Contrast',
                subtitle:
                    'Enhance visibility with bolder colors and darker borders.',
                value: _enableHighContrast,
                onChanged: (val) {
                  setState(() => _enableHighContrast = val);
                  context.read<SettingsCubit>().toggleHighContrast(val);
                },
              ),
              const SizedBox(height: 24),

              // Outdoor Image Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1592982537447-7440770cbfc9?auto=format&fit=crop&w=1000&q=80',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black38,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Optimized for outdoor use',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Data Privacy Callout Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E5620),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFFF59E0B),
                      size: 24,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Your safety and data privacy are our priority.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Finish Setup Button
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5620),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final user = UserEntity(
                      uid: 'farmer_${DateTime.now().millisecondsSinceEpoch}',
                      email: 'claudine@agrosafe.rw',
                      fullName: widget.farmerName.isNotEmpty
                          ? widget.farmerName
                          : 'Claudine Uwimana',
                      role: 'Smallholder Farmer',
                      farmLocation: widget.district.isNotEmpty
                          ? widget.district
                          : 'Musanze District',
                    );

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MainNavigationPage(user: user),
                      ),
                    );
                  },
                  child: const Text(
                    'Finish Setup',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrefCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF1E5620), size: 24),
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
                const SizedBox(height: 4),
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
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeColor: const Color(0xFF1E5620),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
