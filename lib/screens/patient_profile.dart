import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/utils/calculate_bmi.dart';

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
                ...EPatientHealthMetricField.values.map((metricType) {
                  final latestMetric = patientMetrics[metricType]?.last;
                  return buildEditableField(
                    context,
                    ref,
                    metricType.name.capitalize(),
                    metricType,
                    latestMetric?.value ?? 0.0,
                  );
                }),
                const SizedBox(height: 16),
                Text(
                    'BMI: ${calculateBMI(heightInCM: currentHeight, weightInKG: currentWeight).toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildEditableField(
    BuildContext context,
    WidgetRef ref,
    String label,
    EPatientHealthMetricField field,
    double value,
  ) {
    return GestureDetector(
      onTap: () => showEditModal(context, ref, label, field, value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value == 0.0 ? 'Enter value' : value.toStringAsFixed(1)),
            ],
          ),
        ),
      ),
    );
  }

  void showEditModal(
    BuildContext context,
    WidgetRef ref,
    String label,
    EPatientHealthMetricField field,
    double initialValue,
  ) {
    final controller = TextEditingController(text: initialValue.toString());

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
                  'Edit $label',
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
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
