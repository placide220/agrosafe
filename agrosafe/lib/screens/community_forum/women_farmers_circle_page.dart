import 'package:flutter/material.dart';
import '../main_navigation/voice_navigation_modal.dart';

class WomenFarmersCirclePage extends StatelessWidget {
  const WomenFarmersCirclePage({super.key});

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF831843),
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
        title: const Text('Women Circle'),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deep Pink Hero Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF831843),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Women Farmers Circle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Empowering female agricultural leaders in Northern Rwanda through shared knowledge and group resources.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF831843),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _showFeedback(
                        context,
                        'Joined Women Farmers Circle Group Chat! 342 members active.',
                      );
                    },
                    icon: const Icon(Icons.group_rounded, size: 20),
                    label: const Text(
                      'Join Group Chat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Workshops Section
            const Text(
              'Upcoming Workshops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),

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
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF831843).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFF831843),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Financial Literacy & Savings',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Friday, Oct 27 • 2:00 PM',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF831843),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Location: Musanze Community Center',
                    style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E5620),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _showFeedback(
                          context,
                          'You have registered for the next Women Farmers '
                          'Circle meeting. See you at the Musanze Community Center!',
                        );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Community Stories Feed Section
            const Text(
              'Community Stories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),

            _buildStoryCard(
              author: 'Umuhoza Marie',
              timeAgo: '2 hours ago',
              title: 'Group Bio-Pesticide Bulk Ordering Success',
              content:
                  'We saved 20% by ordering Emamectin benzoate together. All 18 members received certified supplies yesterday.',
            ),
            const SizedBox(height: 14),

            _buildStoryCard(
              author: 'Claudine Uwimana',
              timeAgo: '5 hours ago',
              title: 'How waiting for Friday soil moisture saved my bean crop',
              content:
                  'AgroSafe recommended waiting until Friday. The seed germination is the best I’ve seen in 3 years!',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard({
    required String author,
    required String timeAgo,
    required String title,
    required String content,
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
                radius: 18,
                backgroundColor: const Color(0xFF831843).withOpacity(0.12),
                child: Text(
                  author.substring(0, 1),
                  style: const TextStyle(
                    color: Color(0xFF831843),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
