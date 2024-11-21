import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/widgets/body_metrics_card.dart';

class BodyMetricsSection extends StatelessWidget {
  final Map<EPatientHealthMetricField, List<PatientHealthMetric>>
      patientMetrics;
  final Function(EPatientHealthMetricField metricType) onEdit;

  const BodyMetricsSection({
    super.key,
    required this.patientMetrics,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (var metricType in [
          EPatientHealthMetricField.chest,
          EPatientHealthMetricField.waist,
          EPatientHealthMetricField.hips,
        ])
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: InkWell(
              onTap: () => onEdit(metricType),
              child: BodyMetricsCard(
                label: getLabelForMetric(metricType),
                value: patientMetrics[metricType]?.last.value ?? 0.0,
                previousValue: patientMetrics[metricType]?.first.value ?? 0.0,
              ),
            ),
          ),
      ],
    );
  }
}
