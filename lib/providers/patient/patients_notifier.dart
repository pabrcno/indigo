import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'patients_notifier_state.dart';

class PatientsNotifier extends StateNotifier<PatientsNotifierState> {
  final IPatientRepo _repository;

  PatientsNotifier(this._repository) : super(const PatientsNotifierState());

  /// Fetch all patients
  Future<void> fetchAllPatients() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final patients = await _repository.getAllPatients();
      state = state.copyWith(patients: patients, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch patients: ${e.toString()}',
      );
    }
  }

  /// Search patients by name
  Future<void> searchPatientsByName(String name) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final patients = await _repository.searchPatientByName(name);
      state = state.copyWith(patients: patients, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to search patients: ${e.toString()}',
      );
    }
  }
}
