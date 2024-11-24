import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/constants/colors.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/presentation/widgets/edit_metrics_modal.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/presentation/widgets/metrics_cards_section.dart';
import 'package:indigo/presentation/widgets/bmi_calculator_section.dart';
import 'package:indigo/presentation/widgets/body_metrics_section.dart';
import 'package:indigo/presentation/widgets/notes_card.dart';

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
        .read(patientMetricsProvider.notifier)
        .fetchPatientMetrics(widget.patient.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final patientMetrics = ref.watch(patientMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPurple,
        leading: IconButton(
          key: const Key('back_button'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${widget.patient.name} ${widget.patient.lastName}',
          key: const Key('app_bar_title'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: _fetchMetricsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                key: Key('loading_indicator'),
                child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              key: const Key('error_message'),
              child:
                  Text('Error loading metrics. ${snapshot.error.toString()}'),
            );
          }

          if (screenWidth > 1200) {
            return WideScreenLayout(
              patient: widget.patient,
              patientMetrics: patientMetrics,
              onEditMetric: (metricType) => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return EditMetricsModal(
                    fieldLabel: getLabelForMetric(metricType),
                    onSave: (value) async {
                      await ref.read(patientMetricsProvider.notifier).addMetric(
                            patientId: widget.patient.id,
                            metricType: metricType,
                            value: value,
                          );
                    },
                  );
                },
              ),
            );
          } else {
            return MediumScreenLayout(
              patient: widget.patient,
              patientMetrics: patientMetrics,
              onEditMetric: (metricType) => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return EditMetricsModal(
                    fieldLabel: getLabelForMetric(metricType),
                    onSave: (value) async {
                      await ref.read(patientMetricsProvider.notifier).addMetric(
                            patientId: widget.patient.id,
                            metricType: metricType,
                            value: value,
                          );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class WideScreenLayout extends StatelessWidget {
  final Patient patient;
  final dynamic patientMetrics;
  final void Function(EPatientHealthMetricField metricType) onEditMetric;

  const WideScreenLayout({
    super.key,
    required this.patient,
    required this.patientMetrics,
    required this.onEditMetric,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('wideScreenLayout'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MetricsCardsSection(
                  key: const Key('metricsCardsSection'),
                  patientMetrics: patientMetrics,
                  onEdit: onEditMetric,
                ),
                const SizedBox(height: standardSpacing),
                BMICalculatorSection(
                  key: const Key('bmiCalculatorSection'),
                  patientMetrics: patientMetrics,
                  onEdit: onEditMetric,
                ),
                const SizedBox(height: standardSpacing),
                BodyMetricsSection(
                  key: const Key('bodyMetricsSection'),
                  patientMetrics: patientMetrics,
                  onEdit: onEditMetric,
                ),
              ],
            ),
          ),
          const SizedBox(width: standardSpacing),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                NotesCard(
                  key: const Key('notesCard'),
                  notes: patient.notes ?? '',
                  onCreate: () {
                    // Handle note creation
                  },
                ),
                const SizedBox(height: 48),
                Image.asset(
                  "assets/images/patient.png",
                  fit: BoxFit.fitHeight,
                  key: const Key('patientImage'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MediumScreenLayout extends StatelessWidget {
  final Patient patient;
  final dynamic patientMetrics;
  final void Function(EPatientHealthMetricField metricType) onEditMetric;

  const MediumScreenLayout({
    super.key,
    required this.patient,
    required this.patientMetrics,
    required this.onEditMetric,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('mediumScreenLayout'),
      padding: const EdgeInsets.all(standardSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MetricsCardsSection(
            key: const Key('metricsCardsSection'),
            patientMetrics: patientMetrics,
            onEdit: onEditMetric,
          ),
          const SizedBox(height: standardSpacing),
          BMICalculatorSection(
            key: const Key('bmiCalculatorSection'),
            patientMetrics: patientMetrics,
            onEdit: onEditMetric,
          ),
          const SizedBox(height: standardSpacing),
          BodyMetricsSection(
            key: const Key('bodyMetricsSection'),
            patientMetrics: patientMetrics,
            onEdit: onEditMetric,
          ),
          const SizedBox(height: standardSpacing),
          NotesCard(
            key: const Key('notesCard'),
            notes: patient.notes ?? '',
            onCreate: () {
              // Handle note creation
            },
          ),
        ],
      ),
    );
  }
}
