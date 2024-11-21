import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/presentation/widgets/ruler_widget.dart';
import 'package:indigo/presentation/widgets/bmi_indicator.dart';
import 'package:indigo/presentation/utils/calculate_bmi.dart';

class BMICalculatorSection extends StatelessWidget {
  final Map<EPatientHealthMetricField, List<PatientHealthMetric>>
      patientMetrics;
  final Function(EPatientHealthMetricField metricType) onEdit;

  const BMICalculatorSection({
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Calculadora BMI",
          style: Theme.of(context)
              .textTheme
              .titleLarge, // Use a predefined text style
        ),
        const SizedBox(height: 16),
        // Top row with two ruler widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onEdit(EPatientHealthMetricField.weight),
                child: RulerWidget(
                  unit: getUnitForMetric(EPatientHealthMetricField.weight),
                  label: getLabelForMetric(EPatientHealthMetricField.weight),
                  value: weight,
                  backgroundColor:
                      getColorForMetric(EPatientHealthMetricField.weight),
                ),
              ),
            ),
            const SizedBox(width: 12), // Spacing between the two rulers
            Expanded(
              child: InkWell(
                onTap: () => onEdit(EPatientHealthMetricField.height),
                child: RulerWidget(
                  unit: getUnitForMetric(EPatientHealthMetricField.height),
                  label: getLabelForMetric(EPatientHealthMetricField.height),
                  value: height,
                  backgroundColor:
                      getColorForMetric(EPatientHealthMetricField.height),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16), // Spacing between rows

        // Bottom row with the BMI Indicator
        if (height > 0 && weight > 0)
          Container(
            alignment: Alignment.center,
            child: BMIIndicator(
              bmiValue: calculateBMI(
                heightInCM: height,
                weightInKG: weight,
              ),
            ),
          ),
      ],
    );
  }
}
