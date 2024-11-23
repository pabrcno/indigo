import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_repository_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/presentation/screens/patients_screen.dart';

import 'patients_screen_test.mocks.dart';

@GenerateMocks([IPatientRepo])
void main() {
  late MockIPatientRepo mockRepo;

  setUp(() {
    mockRepo = MockIPatientRepo();
  });

  group('PatientsScreen Tests', () {
    testWidgets('displays loading indicator while fetching patients',
        (WidgetTester tester) async {
      when(mockRepo.getAllPatients())
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 2)));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientsRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: const MaterialApp(
            home: PatientsScreen(),
          ),
        ),
      );

      expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
    });

    testWidgets('displays error message if fetching patients fails',
        (WidgetTester tester) async {
      when(mockRepo.getAllPatients())
          .thenThrow(Exception('Error fetching patients'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientsRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: const MaterialApp(
            home: PatientsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('error_message')), findsOneWidget);
    });

    testWidgets('displays list of patients when data is available',
        (WidgetTester tester) async {
      final mockPatients = [
        const Patient(
            id: 1,
            name: 'John',
            lastName: 'Doe',
            notes: 'Test note',
            number: 123),
        const Patient(
            id: 2,
            name: 'Jane',
            lastName: 'Smith',
            notes: 'Another note',
            number: 456),
      ];

      when(mockRepo.getAllPatients()).thenAnswer((_) async => mockPatients);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientsRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: const MaterialApp(
            home: PatientsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('patients_list')), findsOneWidget);
      expect(find.byKey(const Key('patient_row_0')), findsOneWidget);
      expect(find.byKey(const Key('patient_row_1')), findsOneWidget);
    });

    testWidgets('search filters the list of patients',
        (WidgetTester tester) async {
      final mockPatients = [
        const Patient(
            id: 1,
            name: 'John',
            lastName: 'Doe',
            notes: 'Test note',
            number: 123),
        const Patient(
            id: 2,
            name: 'Jane',
            lastName: 'Smith',
            notes: 'Another note',
            number: 456),
      ];

      when(mockRepo.searchPatientByName(any))
          .thenAnswer((_) async => mockPatients);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            patientsRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: const MaterialApp(
            home: PatientsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('search_field')), 'John');
      await tester.pumpAndSettle();

      verify(mockRepo.searchPatientByName(any)).called(1);
    });
  });
}
