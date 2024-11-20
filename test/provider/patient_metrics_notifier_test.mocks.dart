// Mocks generated by Mockito 5.4.4 from annotations
// in indigo/test/provider/patient_metrics_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart'
    as _i2;
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [IPatientMetricsRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPatientMetricsRepo extends _i1.Mock
    implements _i2.IPatientMetricsRepo {
  MockIPatientMetricsRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> insertMetricRecord(_i4.PatientHealthMetric? record) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertMetricRecord,
          [record],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.PatientHealthMetric>> getMetricsHistory(
    int? patientId,
    String? metricType,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMetricsHistory,
          [
            patientId,
            metricType,
          ],
        ),
        returnValue: _i3.Future<List<_i4.PatientHealthMetric>>.value(
            <_i4.PatientHealthMetric>[]),
      ) as _i3.Future<List<_i4.PatientHealthMetric>>);

  @override
  _i3.Future<List<_i4.PatientHealthMetric>> getMetricsByPatientId(
          int? patientId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMetricsByPatientId,
          [patientId],
        ),
        returnValue: _i3.Future<List<_i4.PatientHealthMetric>>.value(
            <_i4.PatientHealthMetric>[]),
      ) as _i3.Future<List<_i4.PatientHealthMetric>>);

  @override
  _i3.Future<int> deleteMetric(int? metricId) => (super.noSuchMethod(
        Invocation.method(
          #deleteMetric,
          [metricId],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}
