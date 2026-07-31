import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/weather_service.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../main_navigation/voice_navigation_modal.dart';
import 'weather_calendar_page.dart';

class WeatherForecastDetailPage extends StatefulWidget {
  const WeatherForecastDetailPage({super.key});

  @override
  State<WeatherForecastDetailPage> createState() =>
      _WeatherForecastDetailPageState();
}

class _WeatherForecastDetailPageState extends State<WeatherForecastDetailPage> {
  String _selectedDistrict = 'Musanze District';
  String _selectedProvince = 'Northern Province, Rwanda';
  WeatherData? _liveWeather;

  final List<Map<String, String>> _districts = const [
    {'district': 'Musanze District', 'province': 'Northern Province, Rwanda'},
    {'district': 'Nyabihu District', 'province': 'Western Province, Rwanda'},
    {'district': 'Rubavu District', 'province': 'Western Province, Rwanda'},
    {'district': 'Gicumbi District', 'province': 'Northern Province, Rwanda'},
    {'district': 'Kigali City', 'province': 'Capital Region, Rwanda'},
    {'district': 'Huye District', 'province': 'Southern Province, Rwanda'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchWeatherForDistrict(_selectedDistrict);
  }

  Future<void> _fetchWeatherForDistrict(String district) async {
    final data = await WeatherService().fetchLiveWeather(district: district);
    if (mounted) {
      setState(() {
        _liveWeather = data;
      });
    }
  }

  void _triggerAudio(BuildContext context, String text) {
    AudioService().speakKinyarwandaPrompt(context: context, text: text);
  }

  void _selectLocationDialog(BuildContext context, bool isRw) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isRw ? 'Hitamo Akarere k’Ihinga' : 'Select Farm Location (GPS)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5620),
                ),
              ),
              const SizedBox(height: 12),
              ..._districts.map((item) {
                final isSelected = item['district'] == _selectedDistrict;
                return ListTile(
                  leading: Icon(
                    Icons.location_on_rounded,
                    color: isSelected ? const Color(0xFF1E5620) : Colors.grey,
                  ),
                  title: Text(
                    item['district']!,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? const Color(0xFF1E5620)
                          : Colors.black87,
                    ),
                  ),
                  subtitle: Text(item['province']!),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Color(0xFF1E5620))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedDistrict = item['district']!;
                      _selectedProvince = item['province']!;
                    });
                    _fetchWeatherForDistrict(item['district']!);
                    Navigator.pop(ctx);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final isRw = langCode == 'rw';
    final now = DateTime.now();
    final todayFormatted = DateFormat('EEEE, d MMMM yyyy').format(now);

    final currentTemp = _liveWeather != null
        ? '${_liveWeather!.currentTemp.round()}°C'
        : '29°C';
    final condition = _liveWeather != null
        ? (isRw ? _liveWeather!.conditionKinyarwanda : _liveWeather!.condition)
        : (isRw ? 'Bicye by’Ibicu' : 'Partly Cloudy');
    final humidity = _liveWeather != null
        ? '${_liveWeather!.humidity}%'
        : '62%';
    final wind = _liveWeather != null
        ? '${_liveWeather!.windSpeed.round()}km/h'
        : '12km/h';

    return Scaffold(
      appBar: AppBar(
        // Only show a back arrow when this screen was pushed onto the stack.
        // As a bottom-nav tab it is the root of the stack, so a back button
        // would have nothing to pop (this is why it appeared "dead").
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
        title: Text(isRw ? 'Ikirere' : 'Weather'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Card with Live GPS Selector
            GestureDetector(
              onTap: () => _selectLocationDialog(context, isRw),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.my_location_rounded,
                                size: 16,
                                color: Color(0xFF1E5620),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isRw
                                    ? 'AHO UHEREREYE (LIVE GPS)'
                                    : 'LIVE GPS LOCATION',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E5620),
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F9F3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'ACTIVE',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E5620),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                _selectedDistrict,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF1E5620),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _selectedProvince,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _triggerAudio(
                          context,
                          isRw
                              ? 'Akarere ka $_selectedDistrict. Ikirere cy\'uyu munsi ni $currentTemp.'
                              : '$_selectedDistrict, $_selectedProvince. Today\'s live temperature is $currentTemp.',
                        );
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF59E0B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.volume_up_rounded,
                          color: Colors.black87,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Today's Main Dark Green Weather Status Card with Live Date & Temp
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E5620),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    isRw
                        ? "Ikirere cy’Uyu Munsi • $todayFormatted"
                        : "Today's Weather • $todayFormatted",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentTemp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    condition,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sun & Cloud Graphic Icon
                  const Icon(
                    Icons.wb_sunny_outlined,
                    size: 72,
                    color: Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherStat(
                        isRw ? 'IMVURA' : 'RAIN',
                        _liveWeather != null &&
                                _liveWeather!.dailyForecasts.isNotEmpty
                            ? '${_liveWeather!.dailyForecasts.first.rainMm.round()}mm'
                            : '0mm',
                      ),
                      _buildWeatherStat(isRw ? 'UMUYAGA' : 'WIND', wind),
                      _buildWeatherStat(
                        isRw ? 'UBUTATSI' : 'HUMIDITY',
                        humidity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Live 7-Day Forecast Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isRw ? 'Iteganyagihe ry’Iminsi 7' : 'Live 7-Day Forecast',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  isRw ? 'Kanda ubugaraguze' : 'Slide for more',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Horizontal Scroll Forecast Cards generated from WeatherService dailyForecasts
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _liveWeather?.dailyForecasts.length ?? 7,
                itemBuilder: (context, index) {
                  final forecast = _liveWeather?.dailyForecasts[index];
                  final dayDate =
                      forecast?.date ?? now.add(Duration(days: index));
                  final dayLabel = index == 0
                      ? 'Today'
                      : DateFormat('EEE d').format(dayDate);

                  final tempRange = forecast != null
                      ? '${forecast.tempMax.round()}°/${forecast.tempMin.round()}°'
                      : '29°/18°';
                  final rainMm = forecast != null
                      ? '${forecast.rainMm.round()}mm'
                      : '0mm';
                  final isAlert = forecast?.isAlert ?? false;

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: _buildForecastDayCard(
                      dayLabel,
                      isAlert
                          ? Icons.thunderstorm_rounded
                          : Icons.wb_sunny_outlined,
                      tempRange,
                      rainMm,
                      isAlert,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Amber Planting Recommendation Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF78350F),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isRw ? 'Inama z’Ihinga' : 'Planting\nRecommendation',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isRw
                              ? 'Umunsi mwiza wo guhinga: Kuwa Kane'
                              : 'Best day to plant: Thursday',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isRw
                              ? 'Imvura nyinshi irateganywa Kuwa Gatatu — Lindira gato mbere yo guhinga kugira ngo imbuto zitatwara n’amazi.'
                              : 'Heavy rain expected Wednesday — wait before planting to prevent seed washout and soil erosion.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4B5563),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E5620),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WeatherCalendarPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_today_rounded, size: 18),
                      label: Text(
                        isRw
                            ? 'Ongeraho mu Kalendari y’Ihinga'
                            : 'Add to My Farming Calendar',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Soil Moisture Card
            _buildMetricCard(
              icon: Icons.water_drop_outlined,
              title: 'Soil Moisture',
              value: 'Optimum',
              subtitle: 'Last updated 2 hours ago',
              valueColor: const Color(0xFF1E5620),
            ),
            const SizedBox(height: 14),

            // Wind Speed Card
            _buildMetricCard(
              icon: Icons.air_rounded,
              title: 'Wind Speed',
              value: 'Low',
              subtitle: 'Safe for spraying fertilizers',
              valueColor: const Color(0xFF1E5620),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastDayCard(
    String day,
    IconData icon,
    String temp,
    String rain,
    bool isRainAlert,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isRainAlert ? const Color(0xFFFEE2E2) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRainAlert
              ? const Color(0xFFDC2626)
              : const Color(0xFFE5E7EB),
          width: isRainAlert ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isRainAlert
                  ? const Color(0xFF991B1B)
                  : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 10),
          Icon(
            icon,
            size: 28,
            color: isRainAlert
                ? const Color(0xFFDC2626)
                : const Color(0xFF111827),
          ),
          const SizedBox(height: 10),
          Text(
            temp,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isRainAlert
                  ? const Color(0xFF991B1B)
                  : const Color(0xFF111827),
            ),
          ),
          Text(
            rain,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isRainAlert
                  ? const Color(0xFFDC2626)
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E5620), size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
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
