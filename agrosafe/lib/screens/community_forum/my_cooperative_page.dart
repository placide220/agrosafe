import 'package:flutter/material.dart';
import '../main_navigation/voice_navigation_modal.dart';

class MyCooperativePage extends StatelessWidget {
  const MyCooperativePage({super.key});

  void _showActionDialog(BuildContext context, String title, String message) {
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
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'OK',
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
        title: const Text('My Cooperative'),
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
            // Dark Green Cooperative Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E5620),
                borderRadius: BorderRadius.circular(24),
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
                          color: const Color(0xFFF59E0B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'ACTIVE MEMBER',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Text(
                        'ID: #4821',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Kivu Coffee & Crop\nCooperative',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Musanze Branch • Northern Rwanda',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4 Quick Action Cards Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.15,
              children: [
                _buildCoopActionCard(
                  icon: Icons.inventory_2_outlined,
                  title: 'Grain Storage',
                  subtitle: 'Capacity & Receipts',
                  onTap: () {
                    _showActionDialog(
                      context,
                      'Grain Storage Facility',
                      'Your current registered allocation: 450kg stored at Warehouse B. Storage fee: 0 RWF (Coop Covered).',
                    );
                  },
                ),
                _buildCoopActionCard(
                  icon: Icons.handyman_outlined,
                  title: 'Shared Tools',
                  subtitle: 'Reserve Equipment',
                  onTap: () {
                    _showActionDialog(
                      context,
                      'Shared Equipment Reservation',
                      'Tractor & Sprayer available for booking starting tomorrow 8:00 AM at Musanze Depot.',
                    );
                  },
                ),
                _buildCoopActionCard(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Group Selling',
                  subtitle: 'Bulk Market Prices',
                  onTap: () {
                    _showActionDialog(
                      context,
                      'Group Selling Pool',
                      'Current Grade A Maize Pool: 1,450 RWF/kg (8% higher than local market rate). Next pool close: Friday.',
                    );
                  },
                ),
                _buildCoopActionCard(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Micro-Loans',
                  subtitle: 'Apply for Support',
                  onTap: () {
                    _showActionDialog(
                      context,
                      'Seasonal Micro-Loan Program',
                      'Eligible for up to 150,000 RWF seed & fertilizer credit. Interest rate: 1.5% per season.',
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Cooperative Announcements Header
            const Text(
              'Cooperative Announcements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),

            _buildAnnouncementItem(
              title: 'Annual Fertilizer Distribution',
              date: 'Oct 25, 2024',
              content:
                  'Pick up your allocated fertilizer bags at the main warehouse between 8 AM and 4 PM. Bring your membership card.',
            ),
            const SizedBox(height: 14),

            _buildAnnouncementItem(
              title: 'Coffee Price Adjustment',
              date: 'Oct 20, 2024',
              content:
                  'High demand in European export markets has led to a 7% increase in buying rates per kg for Grade A beans.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCoopActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF1E5620),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 12),
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
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementItem({
    required String title,
    required String date,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                date,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
