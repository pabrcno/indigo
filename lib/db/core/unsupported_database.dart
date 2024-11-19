// unsupported_database.dart
import 'package:drift/drift.dart';

QueryExecutor openConnection() {
  throw UnsupportedError(
      'The current platform is not supported for the database.');
}
