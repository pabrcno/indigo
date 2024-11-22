import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/core/db.dart';
import 'package:indigo/db/core/web_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final connection = DatabaseConnection.delayed(openAsyncConnection());

  return AppDatabase(connection);
});
