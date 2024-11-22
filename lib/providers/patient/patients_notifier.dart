import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_repo_provider.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'patients_notifier.g.dart';

@riverpod
class PatientsNotifier extends _$PatientsNotifier {
  late final IPatientRepo _repository;

  @override
  FutureOr<List<Patient>> build() async {
    _repository = ref.read(patientsRepositoryProvider); // Inject repository
    return await _repository.getAllPatients(); // Initialize state
  }

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

  Future<void> searchPatientsByName(String name) async {
    state = const AsyncLoading();
    try {
      final patients = await _repository.searchPatientByName(name);
      state = AsyncData(patients);
    } catch (e) {
      state = AsyncError(
          'Failed to search patients: ${e.toString()}', StackTrace.current);
    }
  }
}
