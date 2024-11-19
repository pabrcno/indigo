import 'package:drift/drift.dart';

@DataClassName('PatientRecord')
class PatientsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
}
