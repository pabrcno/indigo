import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:indigo/models/patient/patient.dart';

part 'patients_notifier_state.freezed.dart';

@freezed
class PatientsNotifierState with _$PatientsNotifierState {
  const factory PatientsNotifierState({
    @Default([]) List<Patient> patients, // List of patients
    @Default(false) bool isLoading, // Loading state
    String? errorMessage, // Error message
  }) = _PatientsNotifierState;
}
