import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/db_provider.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_repo.dart';

final patientsRepositoryProvider = Provider<IPatientRepo>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PatientsRepository(db);
});
