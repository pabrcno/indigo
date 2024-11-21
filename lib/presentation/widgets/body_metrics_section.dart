import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/utils/determine_body_shape.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/presentation/widgets/body_metrics_card.dart';

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

    // Fetch the latest values for chest, waist, and hips
    final double chest =
        patientMetrics[EPatientHealthMetricField.chest]?.last.value ?? 0.0;
    final double waist =
        patientMetrics[EPatientHealthMetricField.waist]?.last.value ?? 0.0;
    final double hips =
        patientMetrics[EPatientHealthMetricField.hips]?.last.value ?? 0.0;

    // Determine the body shape
    final String bodyShape = determineBodyShape(chest, waist, hips);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          "Medidas corporales",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: smallSpacing),

        // Body shape tag
        if (bodyShape.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: smallSpacing, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Forma del cuerpo: $bodyShape",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        const SizedBox(height: standardSpacing),
        // Grid of body metrics
        GridView.builder(
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
        ),
      ],
    );
  }
}
