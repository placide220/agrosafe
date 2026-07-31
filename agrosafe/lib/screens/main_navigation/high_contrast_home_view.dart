import 'package:flutter/material.dart';

import '../../features/auth/domain/entities/user_entity.dart';
import '../crop_incident/incident_list_page.dart';
import '../community_forum/women_farmers_circle_page.dart';
import '../safety_misinformation/safety_scam_page.dart';
import '../weather_calendar/weather_calendar_page.dart';

class HighContrastHomeView extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onExitHighContrast;

  const HighContrastHomeView({
    super.key,
    required this.user,
    required this.onExitHighContrast,
  });

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFFFFF00),
        title: const Text(
          'AGROSAFE HIGH CONTRAST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFF00),
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xFFFFFF00),
              size: 36,
            ),
            onPressed: onExitHighContrast,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Severe Flood Alert Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFFF00), width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFFFFF00),
                        size: 40,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'FLOOD WARNING',
                        style: TextStyle(
                          color: Color(0xFFFFFF00),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Heavy rain in Musanze district. Delay bean planting until Friday.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // High-Contrast Quick Action Buttons with 40px Icons
            _buildHighContrastButton(
              icon: Icons.calendar_today_rounded,
              label: '1. PLANTING CALENDAR',
              onTap: () => _open(context, const WeatherCalendarPage()),
            ),
            const SizedBox(height: 16),
            _buildHighContrastButton(
              icon: Icons.security_rounded,
              label: '2. SCAM ALERTS',
              onTap: () => _open(context, const SafetyScamPage()),
            ),
            const SizedBox(height: 16),
            _buildHighContrastButton(
              icon: Icons.bug_report_rounded,
              label: '3. CROP INCIDENTS',
              onTap: () => _open(context, IncidentListPage(user: user)),
            ),
            const SizedBox(height: 16),
            _buildHighContrastButton(
              icon: Icons.groups_rounded,
              label: '4. WOMEN CIRCLE',
              onTap: () => _open(context, const WomenFarmersCirclePage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighContrastButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFF00),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 40),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
