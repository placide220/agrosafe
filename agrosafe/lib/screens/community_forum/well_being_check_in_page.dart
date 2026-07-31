import 'package:flutter/material.dart';
import '../main_navigation/voice_navigation_modal.dart';

class WellBeingCheckInPage extends StatefulWidget {
  const WellBeingCheckInPage({super.key});

  @override
  State<WellBeingCheckInPage> createState() => _WellBeingCheckInPageState();
}

class _WellBeingCheckInPageState extends State<WellBeingCheckInPage> {
  int _selectedMood = 3;

  final List<Map<String, dynamic>> _moods = const [
    {
      'score': 1,
      'label': 'Stressed',
      'icon': Icons.sentiment_very_dissatisfied,
    },
    {'score': 2, 'label': 'Anxious', 'icon': Icons.sentiment_dissatisfied},
    {'score': 3, 'label': 'Okay', 'icon': Icons.sentiment_neutral},
    {'score': 4, 'label': 'Hopeful', 'icon': Icons.sentiment_satisfied},
    {'score': 5, 'label': 'Confident', 'icon': Icons.sentiment_very_satisfied},
  ];

  void _showResourceDialog(String title, String details) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E5620),
          ),
        ),
        content: Text(details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Close',
              style: TextStyle(
                color: Color(0xFF1E5620),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Farmer Well-Being'),
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
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volume_up_rounded,
                  color: Colors.black87,
                  size: 22,
                ),
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
            // Intro Amber/Yellow Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Health Matters',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Farming can be stressful. Taking care of your mind and body is essential for a successful harvest.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF92400E),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 16),

            // 5 Mood Options Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _moods.map((m) {
                final isSelected = _selectedMood == m['score'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = m['score'] as int;
                    });
                  },
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1E5620)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1E5620)
                                : const Color(0xFFE5E7EB),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          m['icon'] as IconData,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF6B7280),
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        m['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF1E5620)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // Support & Resources Header
            const Text(
              'Support & Resources',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),

            _buildResourceTile(
              icon: Icons.spa_outlined,
              title: 'Stress Relief Tips',
              subtitle: 'Simple breathing & resting techniques',
            ),
            const SizedBox(height: 10),

            _buildResourceTile(
              icon: Icons.people_outline_rounded,
              title: 'Peer Support Group',
              subtitle: 'Connect with local farmer support circles',
            ),
            const SizedBox(height: 10),

            _buildResourceTile(
              icon: Icons.phone_outlined,
              title: 'Confidential Hotline',
              subtitle: 'Talk with a community health counselor',
            ),
            const SizedBox(height: 28),

            // Save Check-in Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5620),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Well-being check-in saved!'),
                      backgroundColor: Color(0xFF1E5620),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Check-in',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () {
        _showResourceDialog(
          title,
          '$subtitle. Access free guidance and support through your local AgroSafe health partnership network.',
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1E5620), size: 26),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
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
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}
