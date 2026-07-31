import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/crop_incident/presentation/bloc/incident_bloc.dart';
import '../../features/crop_incident/presentation/bloc/incident_event.dart';
import '../../features/crop_incident/presentation/bloc/incident_state.dart';
import '../../features/crop_incident/presentation/widgets/incident_card.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../settings_profile/settings_profile_page.dart';
import 'add_edit_incident_page.dart';
import 'incident_detail_page.dart';

class IncidentListPage extends StatefulWidget {
  final UserEntity user;

  const IncidentListPage({super.key, required this.user});

  @override
  State<IncidentListPage> createState() => _IncidentListPageState();
}

class _IncidentListPageState extends State<IncidentListPage> {
  String _selectedSeverity = 'All';

  @override
  void initState() {
    super.initState();
    context.read<IncidentBloc>().add(LoadIncidentsEvent(widget.user.uid));
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<SettingsCubit>().state.settings.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18nStrings.get('incidents', langCode)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings & Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SettingsProfilePage(user: widget.user),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<IncidentBloc>().add(
                LoadIncidentsEvent(widget.user.uid),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Filter Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Critical', 'High', 'Medium', 'Low'].map((
                  severity,
                ) {
                  final isSelected = _selectedSeverity == severity;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(severity),
                      selected: isSelected,
                      selectedColor: const Color(0xFF1E5620),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedSeverity = severity;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<IncidentBloc, IncidentState>(
              listener: (context, state) {
                if (state is IncidentActionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green.shade700,
                    ),
                  );
                } else if (state is IncidentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red.shade700,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is IncidentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                List incidents = [];
                if (state is IncidentLoaded) {
                  incidents = state.incidents;
                } else if (state is IncidentActionSuccess) {
                  incidents = state.incidents;
                }

                if (_selectedSeverity != 'All') {
                  incidents = incidents
                      .where(
                        (i) =>
                            i.severity.toLowerCase() ==
                            _selectedSeverity.toLowerCase(),
                      )
                      .toList();
                }

                if (incidents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bug_report_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          I18nStrings.get('no_incidents', langCode),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: incidents.length,
                  itemBuilder: (context, index) {
                    final item = incidents[index];
                    return IncidentCard(
                      incident: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => IncidentDetailPage(
                              incident: item,
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        _showDeleteConfirmDialog(context, item.id, langCode);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddEditIncidentPage(user: widget.user),
            ),
          );
        },
        backgroundColor: const Color(0xFF1E5620),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_alert_rounded),
        label: Text(I18nStrings.get('add_incident', langCode)),
      ),
    );
  }

  void _showDeleteConfirmDialog(
    BuildContext context,
    String incidentId,
    String langCode,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(I18nStrings.get('delete_incident', langCode)),
        content: Text(I18nStrings.get('confirm_delete', langCode)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(I18nStrings.get('cancel', langCode)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<IncidentBloc>().add(
                DeleteIncidentEvent(
                  incidentId: incidentId,
                  userId: widget.user.uid,
                ),
              );
            },
            child: Text(I18nStrings.get('delete', langCode)),
          ),
        ],
      ),
    );
  }
}
