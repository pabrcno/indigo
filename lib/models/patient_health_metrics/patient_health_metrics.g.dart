// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_health_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientHealthMetricsImpl _$$PatientHealthMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientHealthMetricsImpl(
      glucose: (json['glucose'] as num?)?.toDouble() ?? 0.0,
      bloodPressure: (json['bloodPressure'] as num?)?.toDouble() ?? 0.0,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      respiratoryRate: (json['respiratoryRate'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      chest: (json['chest'] as num?)?.toDouble() ?? 0.0,
      waist: (json['waist'] as num?)?.toDouble() ?? 0.0,
      hips: (json['hips'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PatientHealthMetricsImplToJson(
        _$PatientHealthMetricsImpl instance) =>
    <String, dynamic>{
      'glucose': instance.glucose,
      'bloodPressure': instance.bloodPressure,
      'temperature': instance.temperature,
      'respiratoryRate': instance.respiratoryRate,
      'height': instance.height,
      'weight': instance.weight,
      'chest': instance.chest,
      'waist': instance.waist,
      'hips': instance.hips,
    };
