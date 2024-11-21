import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';

import 'package:indigo/widgets/metrics_cards_section.dart';
import 'package:indigo/widgets/bmi_calculator_section.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1200; // Large screens
    final isMediumScreen = screenWidth > 800 && screenWidth <= 1200; // Medium
    final patientMetrics = ref.watch(patientMetricsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4263EB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${widget.patient.name} ${widget.patient.lastName}',
          style: const TextStyle(color: Colors.white),
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics sections
                if (isWideScreen)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MetricsCardsSection(
                              patientMetrics: patientMetrics,
                              onEdit: (metricType) => showEditModal(
                                  context, ref, metricType, widget.patient.id),
                            ),
                            const SizedBox(height: 16),
                            BMICalculatorSection(
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
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NotesCard(
                              notes: widget.patient.notes ?? '',
                              onCreate: () {
                                // Handle note creation
                              },
                            ),
                            const SizedBox(height: 48),
                            if (screenWidth >
                                1200) // Show image only for wide screens
                              Image.asset(
                                "assets/images/patient.png",
                                fit: BoxFit.fitHeight,
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
                else if (isMediumScreen)
                  // Medium Screen: Show Notes at the Bottom
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MetricsCardsSection(
                        patientMetrics: patientMetrics,
                        onEdit: (metricType) => showEditModal(
                            context, ref, metricType, widget.patient.id),
                      ),
                      const SizedBox(height: 16),
                      BMICalculatorSection(
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
                  )
                else
                  // Small Screen: Show Notes below all sections
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MetricsCardsSection(
                        patientMetrics: patientMetrics,
                        onEdit: (metricType) => showEditModal(
                            context, ref, metricType, widget.patient.id),
                      ),
                      const SizedBox(height: 16),
                      BMICalculatorSection(
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
              ],
            ),
          );
        },
      ),
    );
  }
}
