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
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    final int crossAxisCount = screenWidth > 1200
        ? 3
        : screenWidth > 800
            ? 2
            : 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2, // Adjust as needed based on card design
      ),
      shrinkWrap: true, // Ensures GridView fits the available space
      physics:
          const NeverScrollableScrollPhysics(), // Prevent internal scrolling
      itemCount: 3, // Number of metrics to display
      itemBuilder: (context, index) {
        final metricType = [
          EPatientHealthMetricField.chest,
          EPatientHealthMetricField.waist,
          EPatientHealthMetricField.hips,
        ][index];

        return InkWell(
          onTap: () => onEdit(metricType),
          child: BodyMetricsCard(
            label: getLabelForMetric(metricType),
            value: patientMetrics[metricType]?.last.value ?? 0.0,
            previousValue: patientMetrics[metricType]?.first.value ?? 0.0,
          ),
        );
      },
    );
  }
}
