import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/utils/calculate_bmi.dart';
import 'package:indigo/widgets/bmi_indicator.dart';
import 'package:indigo/widgets/body_metrics_card.dart';
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
                      showEditModal(context, ref, metricType);
                    },
                    child: PatientMetricHistoryChart(
                      icon: getIconForMetric(metricType),
                      unit: getUnitForMetric(metricType),
                      label: getLabelForMetric(metricType),
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
                      showEditModal(context, ref, metricType);
                    },
                    child: RulerWidget(
                      unit: getUnitForMetric(metricType),
                      label: getLabelForMetric(metricType),
                      value: history.isNotEmpty
                          ? history.last.value
                          : 0.0, // Default to 0 if history is empty
                      backgroundColor: getColorForMetric(metricType),
                    ),
                  );
                }),
                ...[
                  EPatientHealthMetricField.chest,
                  EPatientHealthMetricField.waist,
                  EPatientHealthMetricField.hips
                ].map((metricType) {
                  final history = patientMetrics[metricType] ?? [];

                  return GestureDetector(
                    onTap: () {
                      showEditModal(context, ref, metricType);
                    },
                    child: BodyMetricsCard(
                      label: getLabelForMetric(metricType),
                      value: history.isNotEmpty
                          ? history.last.value
                          : 0.0, // Default to 0 if history is empty
                      previousValue:
                          history.isNotEmpty ? history.first.value : 0.0,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                BMIIndicator(
                  bmiValue: calculateBMI(
                      heightInCM: currentHeight, weightInKG: currentWeight),
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
    EPatientHealthMetricField field,
  ) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final label = getLabelForMetric(field);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Crear nuevo registro de $label',
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
        return '/72 mmHg';
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
        return const Color(0xFFF3A53F);
      case EPatientHealthMetricField.bloodPressure:
        return const Color(0xFF478F96);
      case EPatientHealthMetricField.temperature:
        return const Color(0xFFF8BDBD);
      case EPatientHealthMetricField.respiratoryRate:
        return const Color(0xFFF6C2FF);
      case EPatientHealthMetricField.height:
        return const Color(0xFFF8DEBD);
      case EPatientHealthMetricField.weight:
        return const Color(0xFFD0FBFF);
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
      case EPatientHealthMetricField.respiratoryRate:
        return Icons.air;
      default:
        return Icons.device_unknown;
    }
  }

  String getLabelForMetric(EPatientHealthMetricField metric) {
    switch (metric) {
      case EPatientHealthMetricField.glucose:
        return 'Glucemia';
      case EPatientHealthMetricField.bloodPressure:
        return 'Presión arterial';
      case EPatientHealthMetricField.temperature:
        return 'Temperatura corporal';
      case EPatientHealthMetricField.respiratoryRate:
        return 'Frecuencia respiratoria';
      case EPatientHealthMetricField.height:
        return 'Altura';
      case EPatientHealthMetricField.weight:
        return 'Peso';
      case EPatientHealthMetricField.chest:
        return 'Pecho';
      case EPatientHealthMetricField.waist:
        return 'Cintura';
      case EPatientHealthMetricField.hips:
        return 'Cadera';
      default:
        return 'Desconocido';
    }
  }
}
