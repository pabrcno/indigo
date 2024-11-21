import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/providers/patient_health_metrics/patient_metrics_provider.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';

void showEditModal(BuildContext context, WidgetRef ref,
    EPatientHealthMetricField field, int patientId) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final label = getLabelForMetric(field);
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(standardSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create new entry for $label',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          patientId: patientId,
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
