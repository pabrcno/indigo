import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient/patient_repo.dart';
import 'package:indigo/providers/patient/patients_notifier.dart';
import 'package:indigo/providers/patient/patients_notifier_state.dart';

final patientsNotifierProvider =
    StateNotifierProvider<PatientsNotifier, PatientsNotifierState>((ref) {
  final repository = ref.watch(patientsRepositoryProvider);
  return PatientsNotifier(repository);
});
