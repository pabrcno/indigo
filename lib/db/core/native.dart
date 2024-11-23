// native.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<DatabaseConnection> constructDbConnection() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'db.sqlite'));
  final db = NativeDatabase(file);

  return DatabaseConnection(db);
}
