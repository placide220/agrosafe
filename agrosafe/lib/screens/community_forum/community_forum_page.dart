import 'package:flutter/material.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import 'ask_an_expert_page.dart';

class CommunityForumPage extends StatefulWidget {
  final UserEntity user;

  const CommunityForumPage({super.key, required this.user});

  @override
  State<CommunityForumPage> createState() => _CommunityForumPageState();
}

class _CommunityForumPageState extends State<CommunityForumPage> {
  String _selectedCategory = 'All Topics';

  final List<String> _categories = [
    'All Topics',
    'Beans',
    'Maize',
    'Pest Control',
    'Soil Health',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
        title: const Text('Community'),
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
            // Scrollable Category Filter Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: const Color(0xFF1E5620),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF374151),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF1E5620)
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Post 1 Card
            _buildForumPostCard(
              authorName: 'Jean-Paul N.',
              location: 'Musanze Sector',
              timeAgo: '2 hours ago',
              title: 'Best fertilizer for rainy season?',
              content:
                  'Should I apply NPK before or after the forecasted heavy rain this Thursday? Looking for advice from experienced farmers.',
              commentsCount: '12',
              likesCount: '24',
            ),
            const SizedBox(height: 16),

            // Post 2 Card
            _buildForumPostCard(
              authorName: 'Marie V.',
              location: 'Nyabihu Sector',
              timeAgo: '5 hours ago',
              title: 'Spotted fall armyworm in Sector 4',
              content:
                  'Be careful everyone, checked my maize today and found early signs. Used organic neem oil spray immediately with great success.',
              commentsCount: '8',
              likesCount: '31',
            ),
            const SizedBox(height: 16),

            // Post 3 Card
            _buildForumPostCard(
              authorName: 'Claudine U.',
              location: 'Musanze District',
              timeAgo: '1 day ago',
              title: 'Bean seed spacing tips for hillside fields',
              content:
                  'Spacing at 20cm instead of 15cm helped prevent mold growth during high humidity days last month.',
              commentsCount: '19',
              likesCount: '45',
            ),
            const SizedBox(height: 24),

            // Ask Community Yellow Button
            SizedBox(
              width: double.infinity,
              height: 52,
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
                    MaterialPageRoute(builder: (_) => const AskAnExpertPage()),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                label: const Text(
                  'Ask Community',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildForumPostCard({
    required String authorName,
    required String location,
    required String timeAgo,
    required String title,
    required String content,
    required String commentsCount,
    required String likesCount,
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
                radius: 20,
                backgroundColor: const Color(0xFF1E5620).withOpacity(0.15),
                child: Text(
                  authorName.substring(0, 1),
                  style: const TextStyle(
                    color: Color(0xFF1E5620),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      '$location • $timeAgo',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
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
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 6),
              Text(
                commentsCount,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(
                Icons.thumb_up_outlined,
                size: 18,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 6),
              Text(
                likesCount,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.share_outlined,
                size: 18,
                color: Color(0xFF6B7280),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
