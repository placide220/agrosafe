import 'package:flutter/material.dart';
import '../main_navigation/voice_navigation_modal.dart';

class AskAnExpertPage extends StatelessWidget {
  const AskAnExpertPage({super.key});

  void _showActionFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1E5620),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
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
        title: const Text('Ask an Expert'),
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
            const Text(
              'Connect directly with certified MINAGRI agronomists and local agricultural extension officers for verified guidance.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Expert 1 Card
            _buildExpertCard(
              context: context,
              name: 'Dr. Emmanuel Nshimiyimana',
              title: 'Senior Agronomist (Crop Health)',
              rating: '4.9 ★ (120 reviews)',
              status: 'Available Today',
              phone: '+250 788 123 456',
            ),
            const SizedBox(height: 16),

            // Expert 2 Card
            _buildExpertCard(
              context: context,
              name: 'Ing. Claire Mukamana',
              title: 'Soil & Fertilizer Specialist',
              rating: '4.8 ★ (85 reviews)',
              status: 'Available Today',
              phone: '+250 788 654 321',
            ),
            const SizedBox(height: 16),

            // Expert 3 Card
            _buildExpertCard(
              context: context,
              name: 'Jean-Luc Habimana',
              title: 'Pest & Disease Control Officer',
              rating: '4.9 ★ (210 reviews)',
              status: 'Available Tomorrow',
              phone: '+250 788 987 654',
            ),
            const SizedBox(height: 24),

            // Emergency Hotline Yellow Banner Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.phone_in_talk_rounded,
                        color: Color(0xFF78350F),
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Emergency Pest Outbreak?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Call the National Agricultural Toll-Free Hotline for immediate rapid response support in your area.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF78350F),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78350F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _showActionFeedback(
                          context,
                          'Calling MINAGRI Emergency Hotline 114 (Toll-Free)...',
                        );
                      },
                      icon: const Icon(Icons.call_rounded, size: 18),
                      label: const Text(
                        'Call Toll-Free 114',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertCard({
    required BuildContext context,
    required String name,
    required String title,
    required String rating,
    required String status,
    required String phone,
  }) {
    return Container(
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
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFF1E5620).withOpacity(0.15),
                child: Text(
                  name.split(' ').last.substring(0, 1),
                  style: const TextStyle(
                    color: Color(0xFF1E5620),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF59E0B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• $status',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5620),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5620),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _showActionFeedback(context, 'Calling $name at $phone...');
                  },
                  icon: const Icon(Icons.call_rounded, size: 18),
                  label: const Text('Call Expert'),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E5620),
                  side: const BorderSide(color: Color(0xFF1E5620)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _showActionFeedback(
                    context,
                    'Opening direct chat session with $name...',
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                label: const Text('Message'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
