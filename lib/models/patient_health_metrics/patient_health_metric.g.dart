// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_health_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientHealthMetricImpl _$$PatientHealthMetricImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientHealthMetricImpl(
      id: (json['id'] as num?)?.toInt(),
      patientId: (json['patientId'] as num).toInt(),
      metricType:
          $enumDecode(_$EPatientHealthMetricFieldEnumMap, json['metricType']),
      value: (json['value'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$PatientHealthMetricImplToJson(
        _$PatientHealthMetricImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'metricType': _$EPatientHealthMetricFieldEnumMap[instance.metricType]!,
      'value': instance.value,
      'recordedAt': instance.recordedAt.toIso8601String(),
    };

const _$EPatientHealthMetricFieldEnumMap = {
  EPatientHealthMetricField.glucose: 'glucose',
  EPatientHealthMetricField.bloodPressure: 'bloodPressure',
  EPatientHealthMetricField.temperature: 'temperature',
  EPatientHealthMetricField.respiratoryRate: 'respiratoryRate',
  EPatientHealthMetricField.height: 'height',
  EPatientHealthMetricField.weight: 'weight',
  EPatientHealthMetricField.chest: 'chest',
  EPatientHealthMetricField.waist: 'waist',
  EPatientHealthMetricField.hips: 'hips',
};
