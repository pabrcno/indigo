// Mocks generated by Mockito 5.4.4 from annotations
// in indigo/test/provider/patient/patient_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:indigo/db/patient/i_patient_repo.dart' as _i2;
import 'package:indigo/models/patient/patient.dart' as _i4;
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

/// A class which mocks [IPatientRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPatientRepo extends _i1.Mock implements _i2.IPatientRepo {
  MockIPatientRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> insertPatient(_i4.Patient? patient) => (super.noSuchMethod(
        Invocation.method(
          #insertPatient,
          [patient],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.Patient>> getAllPatients() => (super.noSuchMethod(
        Invocation.method(
          #getAllPatients,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Patient>>.value(<_i4.Patient>[]),
      ) as _i3.Future<List<_i4.Patient>>);

  @override
  _i3.Future<_i4.Patient?> getPatientById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getPatientById,
          [id],
        ),
        returnValue: _i3.Future<_i4.Patient?>.value(),
      ) as _i3.Future<_i4.Patient?>);

  @override
  _i3.Future<int> deletePatient(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deletePatient,
          [id],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.Patient>> searchPatientByName(String? namePattern) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchPatientByName,
          [namePattern],
        ),
        returnValue: _i3.Future<List<_i4.Patient>>.value(<_i4.Patient>[]),
      ) as _i3.Future<List<_i4.Patient>>);
}