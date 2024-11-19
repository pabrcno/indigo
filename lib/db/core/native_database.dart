import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<DatabaseConnection> openAsyncConnection() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
  return DatabaseConnection(NativeDatabase(file));
}

QueryExecutor openSyncConnection() {
  final dbFolder = Directory.current;
  final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
  return NativeDatabase(file);
}
