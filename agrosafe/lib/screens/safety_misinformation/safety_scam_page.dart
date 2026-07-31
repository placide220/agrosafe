import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/voice_navigation_modal.dart';
import 'check_advice_page.dart';

class SafetyScamPage extends StatefulWidget {
  const SafetyScamPage({super.key});

  @override
  State<SafetyScamPage> createState() => _SafetyScamPageState();
}

class _SafetyScamPageState extends State<SafetyScamPage> {
  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final isRw = langCode == 'rw';

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
        title: const Text('AgroSafe'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VoiceNavigationModal(),
                  ),
                );
              },
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
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Red Alert Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFDC2626),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  isRw
                      ? 'Alert y’Ubutekamutwe mu Karere Kawe'
                      : 'Active Scam Alert in Your Area',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Urgent Warning Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE2E2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'URGENT WARNING',
                                style: TextStyle(
                                  color: Color(0xFFDC2626),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Text(
                              'Jan 24, 2024',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          'Fake "Ganza-Growth"\nFertiliser',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Reports indicate counterfeit bags of "Ganza-Growth" are being sold at local markets in Musanze. The fake product contains mostly sand and harmful chemicals that will destroy your soil quality.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4B5563),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // "How to Identify" Container
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF1E5620),
                              width: 1.5,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: Color(0xFF1E5620),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'How to Identify',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E5620),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                '• Incorrect logo color (Blue instead of Green)',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '• No official certification stamp',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '• Price is 40% lower than standard',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // "Purchased Already?" Red Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.cleaning_services_outlined,
                                color: Color(0xFF991B1B),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Purchased Already?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF991B1B),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Do not apply to crops. Keep the receipt and report to your cooperative officer immediately for legal documentation.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF7F1D1D),
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Product Image Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?auto=format&fit=crop&w=1000&q=80',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recent Alerts Header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Alerts in Musanze',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildRecentAlertItem(
                    'Fake Seeds SMS Phishing',
                    'Dec 02, 2023',
                    'Avoid clicking links in SMS...',
                  ),
                  const SizedBox(height: 10),
                  _buildRecentAlertItem(
                    'Stolen Equipment Resale',
                    'Nov 28, 2023',
                    'Unauthorized dealers selling...',
                  ),
                  const SizedBox(height: 10),
                  _buildRecentAlertItem(
                    'Fake Insurance Agents',
                    'Oct 15, 2023',
                    'Be cautious of individuals posing...',
                  ),
                  const SizedBox(height: 24),

                  // Report a Scam Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CheckAdvicePage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.error_outline_rounded, size: 22),
                      label: const Text(
                        'Report a Scam',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAlertItem(String title, String date, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.black87,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
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
        ],
      ),
    );
  }
}
