import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/db/core/shared.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final connection = DatabaseConnection.delayed(constructDbConnection());
  ref.onDispose(connection.close);
  return AppDatabase(connection);
});
