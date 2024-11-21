import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';

import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

void main() {
  group('getUnitForMetric', () {
    test('returns correct unit for each metric', () {
      expect(getUnitForMetric(EPatientHealthMetricField.glucose), 'mg/dL');
      expect(getUnitForMetric(EPatientHealthMetricField.bloodPressure),
          '/72 mmHg');
      expect(getUnitForMetric(EPatientHealthMetricField.temperature), '°C');
      expect(getUnitForMetric(EPatientHealthMetricField.height), 'cm');
      expect(getUnitForMetric(EPatientHealthMetricField.weight), 'kg');
      expect(getUnitForMetric(EPatientHealthMetricField.respiratoryRate), '');
    });
  });

  group('getColorForMetric', () {
    test('returns correct color for each metric', () {
      expect(getColorForMetric(EPatientHealthMetricField.glucose),
          const Color(0xFFF3A53F));
      expect(getColorForMetric(EPatientHealthMetricField.bloodPressure),
          const Color(0xFF478F96));
      expect(getColorForMetric(EPatientHealthMetricField.temperature),
          const Color(0xFFF8BDBD));
      expect(getColorForMetric(EPatientHealthMetricField.respiratoryRate),
          const Color(0xFFF6C2FF));
      expect(getColorForMetric(EPatientHealthMetricField.height),
          const Color(0xFFF8DEBD));
      expect(getColorForMetric(EPatientHealthMetricField.weight),
          const Color(0xFFD0FBFF));
    });
  });

  group('getIconForMetric', () {
    test('returns correct icon for each metric', () {
      expect(
          getIconForMetric(EPatientHealthMetricField.glucose), Icons.bloodtype);
      expect(getIconForMetric(EPatientHealthMetricField.bloodPressure),
          Icons.favorite);
      expect(getIconForMetric(EPatientHealthMetricField.temperature),
          Icons.thermostat);
      expect(getIconForMetric(EPatientHealthMetricField.height), Icons.height);
      expect(getIconForMetric(EPatientHealthMetricField.weight),
          Icons.fitness_center);
      expect(getIconForMetric(EPatientHealthMetricField.respiratoryRate),
          Icons.air);
    });
  });

  group('getLabelForMetric', () {
    test('returns correct label for each metric', () {
      expect(getLabelForMetric(EPatientHealthMetricField.glucose), 'Glucemia');
      expect(getLabelForMetric(EPatientHealthMetricField.bloodPressure),
          'Presión arterial');
      expect(getLabelForMetric(EPatientHealthMetricField.temperature),
          'Temperatura corporal');
      expect(getLabelForMetric(EPatientHealthMetricField.respiratoryRate),
          'Frecuencia respiratoria');
      expect(getLabelForMetric(EPatientHealthMetricField.height), 'Altura');
      expect(getLabelForMetric(EPatientHealthMetricField.weight), 'Peso');
      expect(getLabelForMetric(EPatientHealthMetricField.chest), 'Pecho');
      expect(getLabelForMetric(EPatientHealthMetricField.waist), 'Cintura');
      expect(getLabelForMetric(EPatientHealthMetricField.hips), 'Cadera');
    });
  });

  group('getStatusForMetric', () {
    test('returns correct status for glucose', () {
      expect(getStatusForMetric(EPatientHealthMetricField.glucose, 65), 'Bajo');
      expect(
          getStatusForMetric(EPatientHealthMetricField.glucose, 70), 'Normal');
      expect(
          getStatusForMetric(EPatientHealthMetricField.glucose, 100), 'Normal');
      expect(
          getStatusForMetric(EPatientHealthMetricField.glucose, 140), 'Normal');
      expect(
          getStatusForMetric(EPatientHealthMetricField.glucose, 150), 'Alto');
    });

    test('returns correct status for blood pressure', () {
      expect(getStatusForMetric(EPatientHealthMetricField.bloodPressure, 85),
          'Bajo');
      expect(getStatusForMetric(EPatientHealthMetricField.bloodPressure, 90),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.bloodPressure, 120),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.bloodPressure, 125),
          'Alto');
    });

    test('returns correct status for temperature', () {
      expect(getStatusForMetric(EPatientHealthMetricField.temperature, 36.0),
          'Bajo');
      expect(getStatusForMetric(EPatientHealthMetricField.temperature, 36.5),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.temperature, 37.5),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.temperature, 38.0),
          'Alto');
    });

    test('returns correct status for respiratory rate', () {
      expect(getStatusForMetric(EPatientHealthMetricField.respiratoryRate, 10),
          'Bajo');
      expect(getStatusForMetric(EPatientHealthMetricField.respiratoryRate, 12),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.respiratoryRate, 20),
          'Normal');
      expect(getStatusForMetric(EPatientHealthMetricField.respiratoryRate, 22),
          'Alto');
    });

    test('returns "Unknown" for unsupported metrics', () {
      expect(
          getStatusForMetric(EPatientHealthMetricField.height, 170), 'Unknown');
      expect(
          getStatusForMetric(EPatientHealthMetricField.weight, 70), 'Unknown');
    });
  });

  group('getStatusColor', () {
    test('returns correct color for status', () {
      expect(getStatusColor('Bajo'), Colors.blue);
      expect(getStatusColor('Normal'), Colors.green);
      expect(getStatusColor('Alto'), Colors.red);
      // Default case
      expect(getStatusColor('Unknown'), Colors.grey);
    });
  });
}
