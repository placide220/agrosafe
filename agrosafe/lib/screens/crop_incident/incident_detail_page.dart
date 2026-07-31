import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/crop_incident/domain/entities/incident_entity.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import 'add_edit_incident_page.dart';

class IncidentDetailPage extends StatelessWidget {
  final IncidentEntity incident;
  final UserEntity user;

  const IncidentDetailPage({
    super.key,
    required this.incident,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(incident.issueType),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      AddEditIncidentPage(user: user, incident: incident),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    incident.severity.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getSeverityColor(incident.severity),
                ),
                Text(
                  DateFormat('MMM dd, yyyy HH:mm').format(incident.reportedAt),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${I18nStrings.get('crop_name', langCode)}: ${incident.cropName}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E5620),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  incident.location,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              I18nStrings.get('description', langCode),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              incident.description,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E5620).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E5620)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF1E5620)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Status: ${incident.status} • Tracked via AgroSafe Cloud',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E5620),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red.shade800;
      case 'high':
        return Colors.deepOrange;
      case 'medium':
        return Colors.amber.shade800;
      case 'low':
      default:
        return Colors.blue.shade700;
    }
  }
}
