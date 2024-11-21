import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/widgets/ruler_widget.dart';
import 'package:indigo/widgets/bmi_indicator.dart';
import 'package:indigo/utils/calculate_bmi.dart';

class RulersSection extends StatelessWidget {
  final Map<EPatientHealthMetricField, List<PatientHealthMetric>>
      patientMetrics;
  final Function(EPatientHealthMetricField metricType) onEdit;

  const RulersSection({
    super.key,
    required this.patientMetrics,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final height =
        patientMetrics[EPatientHealthMetricField.height]?.last.value ?? 0;
    final weight =
        patientMetrics[EPatientHealthMetricField.weight]?.last.value ?? 0;

    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var metricType in [
              EPatientHealthMetricField.weight,
              EPatientHealthMetricField.height,
            ])
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: InkWell(
                  onTap: () => onEdit(metricType),
                  child: RulerWidget(
                    unit: getUnitForMetric(metricType),
                    label: getLabelForMetric(metricType),
                    value: patientMetrics[metricType]?.last.value ?? 0.0,
                    backgroundColor: getColorForMetric(metricType),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (height > 0 && weight > 0)
          BMIIndicator(
              bmiValue: calculateBMI(heightInCM: height, weightInKG: weight)),
      ],
    );
  }
}
