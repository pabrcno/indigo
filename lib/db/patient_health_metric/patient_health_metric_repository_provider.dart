import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/db_provider.dart';
import 'package:indigo/db/patient_health_metric/i_patient_metrics_repo.dart';
import 'package:indigo/db/patient_health_metric/patient_health_metric_repo.dart';

final patientHealthMetricRepositoryProvider =
    Provider<IPatientMetricsRepo>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PatientHealthMetricsRepository(db);
});
