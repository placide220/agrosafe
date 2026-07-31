import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../community_forum/my_cooperative_page.dart';
import '../main_navigation/voice_navigation_modal.dart';

class WeatherCalendarPage extends StatefulWidget {
  const WeatherCalendarPage({super.key});

  @override
  State<WeatherCalendarPage> createState() => _WeatherCalendarPageState();
}

class _WeatherCalendarPageState extends State<WeatherCalendarPage> {
  late DateTime _displayedMonth;
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _displayedMonth = DateTime(_today.year, _today.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        1,
      );
    });
  }

  List<List<int?>> _generateMonthGrid(DateTime monthDate) {
    final firstDayOfWeek =
        DateTime(monthDate.year, monthDate.month, 1).weekday % 7;
    final daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;

    final List<List<int?>> rows = [];
    List<int?> currentRow = List.filled(firstDayOfWeek, null);

    for (int day = 1; day <= daysInMonth; day++) {
      currentRow.add(day);
      if (currentRow.length == 7) {
        rows.add(currentRow);
        currentRow = [];
      }
    }

    if (currentRow.isNotEmpty) {
      while (currentRow.length < 7) {
        currentRow.add(null);
      }
      rows.add(currentRow);
    }

    return rows;
  }

  Color _getDotColorForDay(int day) {
    // Generate realistic status dot based on day pattern
    if (day % 5 == 0) return Colors.red;
    if (day % 3 == 0) return Colors.amber;
    return const Color(0xFF1E5620);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final monthYearString = DateFormat('MMMM yyyy').format(_displayedMonth);
    final monthGrid = _generateMonthGrid(_displayedMonth);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Planting Calendar'),
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
            // Calendar Month Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 28),
                  onPressed: _previousMonth,
                ),
                Column(
                  children: [
                    Text(
                      monthYearString,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Live Calendar • ${DateFormat('d MMMM yyyy').format(_today)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1E5620),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded, size: 28),
                  onPressed: _nextMonth,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Live Calendar Grid Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  // Days of week header row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DayHeader('S'),
                      _DayHeader('M'),
                      _DayHeader('T'),
                      _DayHeader('W'),
                      _DayHeader('T'),
                      _DayHeader('F'),
                      _DayHeader('S'),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFE5E7EB)),
                  // Dynamic Grid Rows
                  ...monthGrid.map((row) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: row.map((day) {
                          if (day == null) {
                            return const SizedBox(width: 36, height: 44);
                          }
                          final isToday =
                              day == _today.day &&
                              _displayedMonth.month == _today.month &&
                              _displayedMonth.year == _today.year;

                          final dotColor = _getDotColorForDay(day);

                          return Container(
                            width: 40,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isToday
                                  ? const Color(0xFFF3F9F3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isToday
                                    ? const Color(0xFF1E5620)
                                    : Colors.transparent,
                                width: 1.8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isToday
                                        ? const Color(0xFF1E5620)
                                        : const Color(0xFF111827),
                                  ),
                                ),
                                if (isToday)
                                  const Text(
                                    'TODAY',
                                    style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E5620),
                                    ),
                                  ),
                                const SizedBox(height: 2),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: dotColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Legend Heading & Cards
            const Text(
              'Legend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 12),

            _buildLegendBox(
              color: const Color(0xFF1E5620),
              title: 'Ideal Planting',
              subtitle: 'Perfect soil moisture & mild weather.',
              bgColor: const Color(0xFFF3F9F3),
              borderColor: const Color(0xFF81C784),
            ),
            const SizedBox(height: 10),

            _buildLegendBox(
              color: const Color(0xFFF59E0B),
              title: 'Caution',
              subtitle: 'Moderate risk of light rain or dry wind.',
              bgColor: const Color(0xFFFFFBEB),
              borderColor: const Color(0xFFFDE68A),
            ),
            const SizedBox(height: 10),

            _buildLegendBox(
              color: const Color(0xFFDC2626),
              title: 'Avoid Planting',
              subtitle: 'Heavy storms or extreme heat predicted.',
              bgColor: const Color(0xFFFEF2F2),
              borderColor: const Color(0xFFFCA5A5),
            ),
            const SizedBox(height: 24),

            // Seasonal Insight Green Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E5620),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seasonal Insight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'The upcoming short rains (Umuhindo) are starting early this year. Focus on maize and beans before the 25th for optimal yields.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MyCooperativePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'View Cooperative Tips',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendBox({
    required Color color,
    required String title,
    required String subtitle,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4B5563),
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

class _DayHeader extends StatelessWidget {
  final String text;
  const _DayHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }
}
