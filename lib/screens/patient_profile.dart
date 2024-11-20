import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/utils/calculate_bmi.dart';
import 'package:indigo/widgets/patient_metric_history_chart.dart';
import 'package:indigo/widgets/ruler_widget.dart';

class PatientProfileScreen extends ConsumerStatefulWidget {
  final int patientId; // Accept a patient ID to fetch data

  const PatientProfileScreen({super.key, required this.patientId});

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
        .fetchPatientMetrics(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    final patientMetrics = ref.watch(patientMetricsNotifierProvider);
    final currentHeight =
        patientMetrics[EPatientHealthMetricField.height]?.last.value ?? 0;
    final currentWeight =
        patientMetrics[EPatientHealthMetricField.weight]?.last.value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
      ),
      body: FutureBuilder(
        future: _fetchMetricsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading metrics. ${snapshot.error.toString()}',
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ...[
                  EPatientHealthMetricField.glucose,
                  EPatientHealthMetricField.bloodPressure,
                  EPatientHealthMetricField.temperature,
                  EPatientHealthMetricField.respiratoryRate
                ].map((metricType) {
                  final history = patientMetrics[metricType] ?? [];

                  return GestureDetector(
                    onTap: () {
                      showEditModal(context, ref, metricType.name, metricType);
                    },
                    child: PatientMetricHistoryChart(
                      icon: getIconForMetric(metricType),
                      unit: getUnitForMetric(metricType),
                      label: metricType.name.capitalize(),
                      metrics: history,
                      curveColor: getColorForMetric(metricType),
                    ),
                  );
                }),
                ...[
                  EPatientHealthMetricField.weight,
                  EPatientHealthMetricField.height,
                ].map((metricType) {
                  final history = patientMetrics[metricType] ?? [];

                  return GestureDetector(
                    onTap: () {
                      showEditModal(context, ref, metricType.name, metricType);
                    },
                    child: RulerWidget(
                      unit: getUnitForMetric(metricType),
                      label: metricType.name.capitalize(),
                      value: history.isNotEmpty
                          ? history.last.value
                          : 0.0, // Default to 0 if history is empty
                      backgroundColor:
                          getColorForMetric(metricType).withOpacity(0.2),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  'BMI: ${calculateBMI(heightInCM: currentHeight, weightInKG: currentWeight).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showEditModal(
    BuildContext context,
    WidgetRef ref,
    String label,
    EPatientHealthMetricField field,
  ) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add new $label measurement',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: label,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final value = double.tryParse(controller.text);
                    if (value != null) {
                      await ref
                          .read(patientMetricsNotifierProvider.notifier)
                          .addMetric(
                            patientId: widget.patientId,
                            metricType: field,
                            value: value,
                          );
                    }
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getUnitForMetric(EPatientHealthMetricField metric) {
    switch (metric) {
      case EPatientHealthMetricField.glucose:
        return 'mg/dL';
      case EPatientHealthMetricField.bloodPressure:
        return 'mmHg';
      case EPatientHealthMetricField.temperature:
        return '°C';
      case EPatientHealthMetricField.height:
        return 'cm';
      case EPatientHealthMetricField.weight:
        return 'kg';
      default:
        return '';
    }
  }

  Color getColorForMetric(EPatientHealthMetricField metric) {
    switch (metric) {
      case EPatientHealthMetricField.glucose:
        return Colors.orange;
      case EPatientHealthMetricField.bloodPressure:
        return Colors.blue;
      case EPatientHealthMetricField.temperature:
        return Colors.red;
      case EPatientHealthMetricField.height:
        return Colors.green;
      case EPatientHealthMetricField.weight:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData getIconForMetric(EPatientHealthMetricField metric) {
    switch (metric) {
      case EPatientHealthMetricField.glucose:
        return Icons.bloodtype;
      case EPatientHealthMetricField.bloodPressure:
        return Icons.favorite;
      case EPatientHealthMetricField.temperature:
        return Icons.thermostat;
      case EPatientHealthMetricField.height:
        return Icons.height;
      case EPatientHealthMetricField.weight:
        return Icons.fitness_center;
      default:
        return Icons.device_unknown;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

String getStatusForMetric(EPatientHealthMetricField metric, double value) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      if (value < 70) return 'Low';
      if (value <= 140) return 'Normal';
      return 'High';
    case EPatientHealthMetricField.bloodPressure:
      if (value < 90) return 'Low';
      if (value <= 120) return 'Normal';
      return 'High';
    case EPatientHealthMetricField.temperature:
      if (value < 36.5) return 'Low';
      if (value <= 37.5) return 'Normal';
      return 'High';

    default:
      return 'Unknown';
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Low':
      return Colors.blue;
    case 'Normal':
      return Colors.green;
    case 'High':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
