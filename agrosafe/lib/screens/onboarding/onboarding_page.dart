import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/main_navigation_page.dart';

class OnboardingPage extends StatefulWidget {
  final UserEntity user;

  const OnboardingPage({super.key, required this.user});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentStep = 0;
  String _selectedLanguage = 'rw';
  String _selectedDistrict = 'Musanze District (Northern Province)';
  final List<String> _selectedCrops = ['Beans', 'Irish Potatoes'];
  bool _isPlayingAudio = false;

  final List<String> _districts = [
    'Musanze District (Northern Province)',
    'Nyabihu District (Western Province)',
    'Burera District (Northern Province)',
    'Rubavu District (Western Province)',
    'Nyamagabe District (Southern Province)',
    'Bugesera District (Eastern Province)',
  ];

  final List<String> _availableCrops = [
    'Beans',
    'Irish Potatoes',
    'Maize',
    'Coffee',
    'Tea',
    'Cassava',
    'Banana',
    'Vegetables',
  ];

  void _toggleAudioPrompt() {
    setState(() {
      _isPlayingAudio = !_isPlayingAudio;
    });

    final message = _selectedLanguage == 'rw'
        ? 'Muraho! AgroSafe irabafasha kumenya ikirere n’ubuhinzi buboneye.'
        : 'Welcome to AgroSafe! Voice assistant will guide your setup.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.volume_up, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF1E5620),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Complete onboarding and navigate to main application
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainNavigationPage(user: widget.user),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AgroSafe Setup'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (_currentStep + 1) / 3,
              backgroundColor: Colors.grey.shade300,
              color: const Color(0xFF1E5620),
              minHeight: 6,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildStepContent(theme),
              ),
            ),
            // Bottom Action Controls
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentStep--;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFF1E5620)),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      child: Text(_currentStep == 2 ? 'Get Started' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(ThemeData theme) {
    switch (_currentStep) {
      case 0:
        return _buildLanguageStep(theme);
      case 1:
        return _buildDistrictStep(theme);
      case 2:
      default:
        return _buildCropsStep(theme);
    }
  }

  Widget _buildLanguageStep(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.language_rounded, size: 56, color: Color(0xFF1E5620)),
        const SizedBox(height: 16),
        Text(
          'Hitamo Ururimi / Select Language',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E5620),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose your preferred language. Voice guidance is available in Kinyarwanda.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 24),
        // One-tap Voice Assistant Banner
        GestureDetector(
          onTap: _toggleAudioPrompt,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E5620).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E5620)),
            ),
            child: Row(
              children: [
                Icon(
                  _isPlayingAudio
                      ? Icons.graphic_eq_rounded
                      : Icons.volume_up_rounded,
                  color: const Color(0xFF1E5620),
                  size: 32,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kanda hano wumve mu Kinyarwanda',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5620),
                        ),
                      ),
                      Text(
                        'Tap here for Kinyarwanda voice prompt',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          elevation: _selectedLanguage == 'rw' ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: _selectedLanguage == 'rw'
                  ? const Color(0xFF1E5620)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            title: const Text(
              'Kinyarwanda (Ururimi rw’Igihugu)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: _selectedLanguage == 'rw'
                ? const Icon(Icons.check_circle, color: Color(0xFF1E5620))
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = 'rw';
              });
              context.read<SettingsCubit>().setLanguageCode('rw');
            },
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: _selectedLanguage == 'en' ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: _selectedLanguage == 'en'
                  ? const Color(0xFF1E5620)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            title: const Text(
              'English (English Language)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: _selectedLanguage == 'en'
                ? const Icon(Icons.check_circle, color: Color(0xFF1E5620))
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = 'en';
              });
              context.read<SettingsCubit>().setLanguageCode('en');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDistrictStep(ThemeData theme) {
    final langCode = _selectedLanguage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 56,
          color: Color(0xFF1E5620),
        ),
        const SizedBox(height: 16),
        Text(
          langCode == 'rw'
              ? 'Hitamo Akarere k’Ubuhinzi'
              : 'Select Farm Location',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E5620),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'AgroSafe uses your location to deliver 7-day hyperlocal weather forecasts.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E5620).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.gps_fixed_rounded, color: Color(0xFF1E5620)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'GPS Auto-Detection: Musanze District detected',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: _selectedDistrict,
          decoration: const InputDecoration(
            labelText: 'District Selection',
            prefixIcon: Icon(Icons.map_outlined),
          ),
          items: _districts
              .map((d) => DropdownMenuItem(value: d, child: Text(d)))
              .toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _selectedDistrict = val;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildCropsStep(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.eco_outlined, size: 56, color: Color(0xFF1E5620)),
        const SizedBox(height: 16),
        Text(
          'Select Main Crops',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E5620),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose the primary crops on your farm to customize disease alerts & spray schedules.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: _availableCrops.map((crop) {
            final isSelected = _selectedCrops.contains(crop);
            return FilterChip(
              label: Text(crop),
              selected: isSelected,
              selectedColor: const Color(0xFF1E5620),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCrops.add(crop);
                  } else {
                    _selectedCrops.remove(crop);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
