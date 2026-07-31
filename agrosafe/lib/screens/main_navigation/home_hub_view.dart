import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/weather_service.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../auth/login_page.dart';
import '../community_forum/my_cooperative_page.dart';
import 'high_contrast_home_view.dart';
import 'voice_navigation_modal.dart';

class HomeHubView extends StatefulWidget {
  final UserEntity user;
  final Function(int) onNavigateTab;

  const HomeHubView({
    super.key,
    required this.user,
    required this.onNavigateTab,
  });

  @override
  State<HomeHubView> createState() => _HomeHubViewState();
}

class _HomeHubViewState extends State<HomeHubView> {
  WeatherData? _liveWeather;

  @override
  void initState() {
    super.initState();
    _loadLiveWeather();
  }

  Future<void> _loadLiveWeather() async {
    final weather = await WeatherService().fetchLiveWeather(
      district: 'Musanze District',
    );
    if (mounted) {
      setState(() {
        _liveWeather = weather;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final isRw = langCode == 'rw';

    final tempString = _liveWeather != null
        ? '${_liveWeather!.currentTemp.round()}°C'
        : '29°C';
    final conditionString = _liveWeather != null
        ? (isRw ? _liveWeather!.conditionKinyarwanda : _liveWeather!.condition)
        : (isRw ? 'Izuba Uyu Munsi' : 'Sunny Today');

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
          IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VoiceNavigationModal()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.contrast_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HighContrastHomeView(
                    user: widget.user,
                    onExitHighContrast: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
            tooltip: 'Sign Out',
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutSubmitted());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Greeting Header with Floating Audio Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isRw
                            ? 'Mwaramutse, ${widget.user.fullName.split(' ').first}'
                            : 'Good morning, ${widget.user.fullName.split(' ').first}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isRw
                            ? 'Murakaza neza mu murima wanyu.'
                            : 'Welcome back to your farm overview.',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VoiceNavigationModal(),
                      ),
                    );
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
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
            const SizedBox(height: 24),

            // Amber Weather Card (screen8.png) with Live Weather Data
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
                      const Icon(
                        Icons.wb_sunny_outlined,
                        size: 36,
                        color: Color(0xFF78350F),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        tempString,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF78350F),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        conditionString,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF78350F),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF78350F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'KIGALI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.black12, height: 1),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 20,
                        color: Color(0xFF78350F),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          isRw
                              ? 'Ikirere cyiza cyane cyo kubagara ibigori uyu munsi. Ubutaka bwumutse.'
                              : 'Ideal conditions for weeding maize today. High visibility and dry soil.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF78350F),
                            height: 1.35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4 Main Module Grid Cards (Weather, Safety, Community, Cooperative)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMainGridCard(
                  icon: Icons.cloud_outlined,
                  title: isRw ? 'Ikirere' : 'Weather',
                  onTap: () => widget.onNavigateTab(1),
                ),
                _buildMainGridCard(
                  icon: Icons.shield_outlined,
                  title: isRw ? 'Ubutekamutwe' : 'Safety',
                  onTap: () => widget.onNavigateTab(2),
                ),
                _buildMainGridCard(
                  icon: Icons.people_outline_rounded,
                  title: isRw ? 'Umuryango' : 'Community',
                  onTap: () => widget.onNavigateTab(3),
                ),
                _buildMainGridCard(
                  icon: Icons.storefront_outlined,
                  title: isRw ? 'Koperative' : 'Cooperative',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MyCooperativePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Market Update Banner Card (Screen 8)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1535242208474-9a279b23b514?auto=format&fit=crop&w=1000&q=80',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black45,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Market Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Maize prices increased by 5% in Kigali markets this week.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMainGridCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E5620),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
