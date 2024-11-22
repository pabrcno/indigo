import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

Future<DatabaseConnection> constructDbConnection() async {
  final result = await WasmDatabase.open(
    databaseName: 'my_database',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.dart.js'),
  );

  if (result.missingFeatures.isNotEmpty) {
    print(
        'Using ${result.chosenImplementation} due to missing browser features: ${result.missingFeatures}');
  }

  return DatabaseConnection(result.resolvedExecutor);
}
