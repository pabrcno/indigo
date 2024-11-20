import 'package:drift/drift.dart';

@DataClassName('PatientRecord')
class PatientsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get number => integer()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id}; // Ensure ID remains the primary key
}
