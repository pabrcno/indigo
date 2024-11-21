import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/widgets/patient_metric_history_chart.dart';

class MetricsCardsSection extends StatelessWidget {
  final Map<EPatientHealthMetricField, List<PatientHealthMetric>>
      patientMetrics;
  final Function(EPatientHealthMetricField metricType) onEdit;

  const MetricsCardsSection({
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
          EPatientHealthMetricField.glucose,
          EPatientHealthMetricField.bloodPressure,
          EPatientHealthMetricField.temperature,
          EPatientHealthMetricField.respiratoryRate,
        ])
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: InkWell(
              onTap: () => onEdit(metricType),
              child: PatientMetricHistoryChart(
                icon: getIconForMetric(metricType),
                unit: getUnitForMetric(metricType),
                label: getLabelForMetric(metricType),
                metrics: patientMetrics[metricType] ?? [],
                curveColor: getColorForMetric(metricType),
              ),
            ),
          ),
      ],
    );
  }
}
