import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/audio_service.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import 'onboarding_name_page.dart';

class OnboardingLanguagePage extends StatefulWidget {
  const OnboardingLanguagePage({super.key});

  @override
  State<OnboardingLanguagePage> createState() => _OnboardingLanguagePageState();
}

class _OnboardingLanguagePageState extends State<OnboardingLanguagePage> {
  String _selectedLanguage = 'rw';
  bool _isPlayingAudio = false;

  void _playAudioPrompt() {
    setState(() => _isPlayingAudio = true);
    final promptText = _selectedLanguage == 'rw'
        ? 'Muraho! Hitamo ururimi ushaka gukoresha muri AgroSafe.'
        : 'Welcome! Select your preferred language in AgroSafe.';

    AudioService().speakKinyarwandaPrompt(
      context: context,
      text: promptText,
      onComplete: () {
        if (mounted) setState(() => _isPlayingAudio = false);
      },
    );
  }

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
            child: GestureDetector(
              onTap: _playAudioPrompt,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E5620),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isPlayingAudio ? Icons.graphic_eq : Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Segmented Progress Bar (4 steps: green, yellow, gray, gray)
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
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Title
              Text(
                'Choose your language.',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              // Subtitle
              const Text(
                'Hitamo ururimi wifuza gukoresha muri AgroSafe.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 36),

              // Language Cards Row
              Row(
                children: [
                  // Kinyarwanda Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedLanguage = 'rw');
                        context.read<SettingsCubit>().setLanguageCode('rw');
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _selectedLanguage == 'rw'
                                ? const Color(0xFF1E5620)
                                : const Color(0xFFD1D5DB),
                            width: _selectedLanguage == 'rw' ? 2.5 : 1.2,
                          ),
                          boxShadow: _selectedLanguage == 'rw'
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF1E5620,
                                    ).withOpacity(0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Flag Icon graphic representation
                            Container(
                              width: 64,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.8,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: const Color(0xFF00A3E0),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: const Color(0xFFFAD201),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: const Color(0xFF1E5620),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Kinyarwanda',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // English Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedLanguage = 'en');
                        context.read<SettingsCubit>().setLanguageCode('en');
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _selectedLanguage == 'en'
                                ? const Color(0xFF1E5620)
                                : const Color(0xFFD1D5DB),
                            width: _selectedLanguage == 'en' ? 2.5 : 1.2,
                          ),
                          boxShadow: _selectedLanguage == 'en'
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF1E5620,
                                    ).withOpacity(0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // UK Flag graphic representation
                            Container(
                              width: 64,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF012169),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.8,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.language_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'English',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Change later text
              const Text(
                'You can change this later in settings.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 20),

              // Continue Button
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const OnboardingNamePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
