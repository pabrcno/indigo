import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

String getUnitForMetric(EPatientHealthMetricField metric) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      return 'mg/dL';
    case EPatientHealthMetricField.bloodPressure:
      return '/72 mmHg';
    case EPatientHealthMetricField.temperature:
      return '°C';
    case EPatientHealthMetricField.height:
      return 'cm';
    case EPatientHealthMetricField.weight:
      return 'kg';
    default:
      return '';
  }
}

Color getColorForMetric(EPatientHealthMetricField metric) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      return const Color(0xFFF3A53F);
    case EPatientHealthMetricField.bloodPressure:
      return const Color(0xFF478F96);
    case EPatientHealthMetricField.temperature:
      return const Color(0xFFF8BDBD);
    case EPatientHealthMetricField.respiratoryRate:
      return const Color(0xFFF6C2FF);
    case EPatientHealthMetricField.height:
      return const Color(0xFFF8DEBD);
    case EPatientHealthMetricField.weight:
      return const Color(0xFFD0FBFF);
    default:
      return Colors.grey;
  }
}

IconData getIconForMetric(EPatientHealthMetricField metric) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      return Icons.bloodtype;
    case EPatientHealthMetricField.bloodPressure:
      return Icons.favorite;
    case EPatientHealthMetricField.temperature:
      return Icons.thermostat;
    case EPatientHealthMetricField.height:
      return Icons.height;
    case EPatientHealthMetricField.weight:
      return Icons.fitness_center;
    case EPatientHealthMetricField.respiratoryRate:
      return Icons.air;
    default:
      return Icons.device_unknown;
  }
}

String getLabelForMetric(EPatientHealthMetricField metric) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      return 'Glucemia';
    case EPatientHealthMetricField.bloodPressure:
      return 'Presión arterial';
    case EPatientHealthMetricField.temperature:
      return 'Temperatura corporal';
    case EPatientHealthMetricField.respiratoryRate:
      return 'Frecuencia respiratoria';
    case EPatientHealthMetricField.height:
      return 'Altura';
    case EPatientHealthMetricField.weight:
      return 'Peso';
    case EPatientHealthMetricField.chest:
      return 'Pecho';
    case EPatientHealthMetricField.waist:
      return 'Cintura';
    case EPatientHealthMetricField.hips:
      return 'Cadera';
    default:
      return 'Desconocido';
  }
}

String getStatusForMetric(EPatientHealthMetricField metric, double value) {
  switch (metric) {
    case EPatientHealthMetricField.glucose:
      if (value < 70) return 'Bajo';
      if (value <= 140) return 'Normal';
      return 'Alto';
    case EPatientHealthMetricField.bloodPressure:
      if (value < 90) return 'Bajo';
      if (value <= 120) return 'Normal';
      return 'Alto';
    case EPatientHealthMetricField.temperature:
      if (value < 36.5) return 'Bajo';
      if (value <= 37.5) return 'Normal';
      return 'Alto';
    case EPatientHealthMetricField.respiratoryRate:
      if (value < 12) return 'Bajo';
      if (value <= 20) return 'Normal';
      return 'Alto';
    default:
      return 'Unknown';
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Bajo':
      return Colors.blue;
    case 'Normal':
      return Colors.green;
    case 'Alto':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
