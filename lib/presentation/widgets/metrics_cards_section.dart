import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/presentation/widgets/patient_metric_history_chart.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    final int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
            ? 2
            : 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      shrinkWrap: true, // Ensures GridView doesn't expand infinitely
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // Total number of metrics to display
      itemBuilder: (context, index) {
        final metricType = [
          EPatientHealthMetricField.glucose,
          EPatientHealthMetricField.bloodPressure,
          EPatientHealthMetricField.temperature,
          EPatientHealthMetricField.respiratoryRate,
        ][index];

        return InkWell(
          onTap: () => onEdit(metricType),
          child: PatientMetricHistoryChart(
            icon: getIconForMetric(metricType),
            unit: getUnitForMetric(metricType),
            label: getLabelForMetric(metricType),
            metrics: patientMetrics[metricType] ?? [],
            curveColor: getColorForMetric(metricType),
          ),
        );
      },
    );
  }
}
