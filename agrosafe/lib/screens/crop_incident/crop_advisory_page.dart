import 'package:flutter/material.dart';
import '../main_navigation/voice_navigation_modal.dart';
import '../weather_calendar/weather_forecast_detail_page.dart';
import 'add_edit_incident_page.dart';

class CropAdvisoryPage extends StatelessWidget {
  const CropAdvisoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Crop Advisory'),
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
            const Text(
              'YOUR FARM STATUS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF78350F),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Recommended Actions',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Based on the heavy rains forecast for Northern Province over the next 48 hours.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 24),

            // Card 1: Beans (Wait)
            _buildCropCard(
              context: context,
              icon: Icons.grass_rounded,
              title: 'Beans',
              description:
                  'Soil saturation level is high. Planting now increases risk of seed rot.',
              statusText: 'Wait',
              statusBg: const Color(0xFFF59E0B),
              statusTextColor: Colors.white,
              actionText: 'View Advice >',
              isActionAlert: false,
              cardBg: Colors.white,
              borderColor: const Color(0xFFE5E7EB),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const WeatherForecastDetailPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card 2: Maize (Safe)
            _buildCropCard(
              context: context,
              icon: Icons.eco_rounded,
              title: 'Maize',
              description:
                  'Current growth stage is resilient to upcoming weather conditions.',
              statusText: 'Safe',
              statusBg: const Color(0xFF1E5620),
              statusTextColor: Colors.white,
              actionText: 'View Details >',
              isActionAlert: false,
              cardBg: Colors.white,
              borderColor: const Color(0xFFE5E7EB),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const WeatherForecastDetailPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card 3: Potatoes (At Risk - Red Container)
            _buildCropCard(
              context: context,
              icon: Icons.warning_amber_rounded,
              title: 'Potatoes (At Risk)',
              description:
                  'High humidity creates ideal conditions for Late Blight fungus.',
              statusText: 'At Risk',
              statusBg: const Color(0xFFDC2626),
              statusTextColor: Colors.white,
              actionText: 'Report Damage / Infection >',
              isActionAlert: true,
              cardBg: const Color(0xFFFEF2F2),
              borderColor: const Color(0xFFFCA5A5),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddEditIncidentPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCropCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String statusText,
    required Color statusBg,
    required Color statusTextColor,
    required String actionText,
    required bool isActionAlert,
    required Color cardBg,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Icon(icon, color: const Color(0xFF1E5620), size: 28),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isActionAlert
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF1E5620),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
