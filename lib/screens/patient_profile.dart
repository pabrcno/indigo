import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metrics.dart';
import 'package:indigo/providers/patient_metrics_provider.dart';

class PatientProfileScreen extends ConsumerWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientMetrics = ref.watch(patientMetricsNotifierProvider);
    final bmi = ref.read(patientMetricsNotifierProvider.notifier).getBMI();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildEditableField(context, ref, 'Glucose',
                EPatientHealthMetricField.glucose, patientMetrics.glucose),
            buildEditableField(
                context,
                ref,
                'Blood Pressure',
                EPatientHealthMetricField.bloodPressure,
                patientMetrics.bloodPressure),
            buildEditableField(
                context,
                ref,
                'Temperature',
                EPatientHealthMetricField.temperature,
                patientMetrics.temperature),
            buildEditableField(
                context,
                ref,
                'Respiratory Rate',
                EPatientHealthMetricField.respiratoryRate,
                patientMetrics.respiratoryRate),
            buildEditableField(context, ref, 'Height (cm)',
                EPatientHealthMetricField.height, patientMetrics.height),
            buildEditableField(context, ref, 'Weight (kg)',
                EPatientHealthMetricField.weight, patientMetrics.weight),
            buildEditableField(context, ref, 'Chest',
                EPatientHealthMetricField.chest, patientMetrics.chest),
            buildEditableField(context, ref, 'Waist',
                EPatientHealthMetricField.waist, patientMetrics.waist),
            buildEditableField(context, ref, 'Hips',
                EPatientHealthMetricField.hips, patientMetrics.hips),
            const SizedBox(height: 16),
            Text('BMI: $bmi'),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(BuildContext context, WidgetRef ref, String label,
      EPatientHealthMetricField field, double value) {
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

  void showEditModal(BuildContext context, WidgetRef ref, String label,
      EPatientHealthMetricField field, double initialValue) {
    final controller = TextEditingController(text: initialValue.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context)
              .viewInsets, // Adjusts padding when keyboard opens
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Edit $label',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
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
                  onPressed: () {
                    final value = double.tryParse(controller.text);
                    if (value != null) {
                      ref
                          .read(patientMetricsNotifierProvider.notifier)
                          .updateMetric(field, value);
                    }
                    Navigator.of(context).pop();
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
