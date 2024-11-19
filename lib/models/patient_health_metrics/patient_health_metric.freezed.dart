// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_health_metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatientHealthMetric _$PatientHealthMetricFromJson(Map<String, dynamic> json) {
  return _PatientHealthMetric.fromJson(json);
}

/// @nodoc
mixin _$PatientHealthMetric {
  int get id => throw _privateConstructorUsedError;
  int get patientId => throw _privateConstructorUsedError; // Foreign k
  EPatientHealthMetricField get metricType =>
      throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError; // Value of the metric
  DateTime get recordedAt => throw _privateConstructorUsedError;

  /// Serializes this PatientHealthMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientHealthMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientHealthMetricCopyWith<PatientHealthMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientHealthMetricCopyWith<$Res> {
  factory $PatientHealthMetricCopyWith(
          PatientHealthMetric value, $Res Function(PatientHealthMetric) then) =
      _$PatientHealthMetricCopyWithImpl<$Res, PatientHealthMetric>;
  @useResult
  $Res call(
      {int id,
      int patientId,
      EPatientHealthMetricField metricType,
      double value,
      DateTime recordedAt});
}

/// @nodoc
class _$PatientHealthMetricCopyWithImpl<$Res, $Val extends PatientHealthMetric>
    implements $PatientHealthMetricCopyWith<$Res> {
  _$PatientHealthMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientHealthMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? metricType = null,
    Object? value = null,
    Object? recordedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int,
      metricType: null == metricType
          ? _value.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as EPatientHealthMetricField,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientHealthMetricImplCopyWith<$Res>
    implements $PatientHealthMetricCopyWith<$Res> {
  factory _$$PatientHealthMetricImplCopyWith(_$PatientHealthMetricImpl value,
          $Res Function(_$PatientHealthMetricImpl) then) =
      __$$PatientHealthMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int patientId,
      EPatientHealthMetricField metricType,
      double value,
      DateTime recordedAt});
}

/// @nodoc
class __$$PatientHealthMetricImplCopyWithImpl<$Res>
    extends _$PatientHealthMetricCopyWithImpl<$Res, _$PatientHealthMetricImpl>
    implements _$$PatientHealthMetricImplCopyWith<$Res> {
  __$$PatientHealthMetricImplCopyWithImpl(_$PatientHealthMetricImpl _value,
      $Res Function(_$PatientHealthMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientHealthMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? metricType = null,
    Object? value = null,
    Object? recordedAt = null,
  }) {
    return _then(_$PatientHealthMetricImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int,
      metricType: null == metricType
          ? _value.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as EPatientHealthMetricField,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientHealthMetricImpl implements _PatientHealthMetric {
  const _$PatientHealthMetricImpl(
      {required this.id,
      required this.patientId,
      required this.metricType,
      required this.value,
      required this.recordedAt});

  factory _$PatientHealthMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientHealthMetricImplFromJson(json);

  @override
  final int id;
  @override
  final int patientId;
// Foreign k
  @override
  final EPatientHealthMetricField metricType;
  @override
  final double value;
// Value of the metric
  @override
  final DateTime recordedAt;

  @override
  String toString() {
    return 'PatientHealthMetric(id: $id, patientId: $patientId, metricType: $metricType, value: $value, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientHealthMetricImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.metricType, metricType) ||
                other.metricType == metricType) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, patientId, metricType, value, recordedAt);

  /// Create a copy of PatientHealthMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientHealthMetricImplCopyWith<_$PatientHealthMetricImpl> get copyWith =>
      __$$PatientHealthMetricImplCopyWithImpl<_$PatientHealthMetricImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientHealthMetricImplToJson(
      this,
    );
  }
}

abstract class _PatientHealthMetric implements PatientHealthMetric {
  const factory _PatientHealthMetric(
      {required final int id,
      required final int patientId,
      required final EPatientHealthMetricField metricType,
      required final double value,
      required final DateTime recordedAt}) = _$PatientHealthMetricImpl;

  factory _PatientHealthMetric.fromJson(Map<String, dynamic> json) =
      _$PatientHealthMetricImpl.fromJson;

  @override
  int get id;
  @override
  int get patientId; // Foreign k
  @override
  EPatientHealthMetricField get metricType;
  @override
  double get value; // Value of the metric
  @override
  DateTime get recordedAt;

  /// Create a copy of PatientHealthMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientHealthMetricImplCopyWith<_$PatientHealthMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
