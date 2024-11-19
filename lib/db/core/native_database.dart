import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

QueryExecutor openSyncConnection() {
  final dbFolder = Directory.current;
  final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
  return NativeDatabase(file);
}
