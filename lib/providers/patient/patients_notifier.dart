import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_repo_provider.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'patients_notifier.g.dart';

@riverpod
class PatientsNotifier extends _$PatientsNotifier {
  late final IPatientRepo _repository;

  @override
  FutureOr<List<Patient>> build({IPatientRepo? repository}) async {
    // Allow repository injection for testing
    _repository = repository ?? ref.watch(patientsRepositoryProvider);
    return await _repository.getAllPatients(); // Initialize with default state
  }

  /// Fetch all patients
  Future<void> fetchAllPatients() async {
    state = const AsyncLoading();
    try {
      final patients = await _repository.getAllPatients();
      state = AsyncData(patients);
    } catch (e) {
      state = AsyncError(
          'Failed to fetch patients: ${e.toString()}', StackTrace.current);
    }
  }

  /// Search patients by name
  Future<void> searchPatientsByName(String name) async {
    state = const AsyncLoading(); // Indicate loading state
    try {
      final patients = await _repository.searchPatientByName(name);
      state = AsyncData(patients);
    } catch (e) {
      state = AsyncError(
          'Failed to search patients: ${e.toString()}', StackTrace.current);
    }
  }
}
