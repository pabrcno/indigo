import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/widgets/metrics_cards_section.dart';
import 'package:indigo/widgets/rulers_section.dart';
import 'package:indigo/widgets/body_metrics_section.dart';
import 'package:indigo/widgets/notes_card.dart';
import 'package:indigo/widgets/show_edit_modal.dart';

class PatientProfileScreen extends ConsumerStatefulWidget {
  final Patient patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  ConsumerState<PatientProfileScreen> createState() =>
      _PatientProfileScreenState();
}

class _PatientProfileScreenState extends ConsumerState<PatientProfileScreen> {
  late Future<void> _fetchMetricsFuture;

  @override
  void initState() {
    super.initState();
    _fetchMetricsFuture = ref
        .read(patientMetricsNotifierProvider.notifier)
        .fetchPatientMetrics(widget.patient.id);
  }

  @override
  Widget build(BuildContext context) {
    final patientMetrics = ref.watch(patientMetricsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4263EB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: _fetchMetricsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child:
                  Text('Error loading metrics. ${snapshot.error.toString()}'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                MetricsCardsSection(
                  patientMetrics: patientMetrics,
                  onEdit: (metricType) => showEditModal(
                      context, ref, metricType, widget.patient.id),
                ),
                const SizedBox(height: 16),
                RulersSection(
                  patientMetrics: patientMetrics,
                  onEdit: (metricType) => showEditModal(
                      context, ref, metricType, widget.patient.id),
                ),
                const SizedBox(height: 16),
                BodyMetricsSection(
                  patientMetrics: patientMetrics,
                  onEdit: (metricType) => showEditModal(
                      context, ref, metricType, widget.patient.id),
                ),
                const SizedBox(height: 16),
                NotesCard(
                  notes: widget.patient.notes ?? '',
                  onCreate: () {
                    // Handle note creation
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
