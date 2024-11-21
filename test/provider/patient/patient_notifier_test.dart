import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/providers/patient/patients_notifier.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/providers/patient/patients_notifier_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'patient_notifier_test.mocks.dart';

@GenerateMocks([IPatientRepo])
void main() {
  late MockIPatientRepo mockRepo;
  late PatientsNotifier notifier;

  setUp(() {
    mockRepo = MockIPatientRepo();
    notifier = PatientsNotifier(mockRepo);
  });

  group('PatientsNotifier', () {
    test('Initial state is empty', () {
      expect(notifier.state, const PatientsNotifierState());
    });

    test('fetchAllPatients updates state with fetched patients', () async {
      // Arrange
      final samplePatients = [
        Patient(
          id: 1,
          number: 1001,
          name: 'John',
          lastName: 'Doe',
          dateOfBirth: DateTime(1990, 1, 1),
          notes: 'Test notes',
        ),
        Patient(
          id: 2,
          number: 1002,
          name: 'Jane',
          lastName: 'Smith',
          dateOfBirth: DateTime(1985, 5, 20),
          notes: null,
        ),
      ];
      when(mockRepo.getAllPatients()).thenAnswer((_) async => samplePatients);

      // Act
      await notifier.fetchAllPatients();

      // Assert
      expect(notifier.state.patients, samplePatients);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
    });

    test('fetchAllPatients handles errors gracefully', () async {
      // Arrange
      when(mockRepo.getAllPatients()).thenThrow(Exception('Network Error'));

      // Act
      await notifier.fetchAllPatients();

      // Assert
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, contains('Failed to fetch patients'));
      expect(notifier.state.patients, isEmpty);
    });

    test('searchPatientsByName updates state with search results', () async {
      // Arrange
      final samplePatients = [
        Patient(
          id: 1,
          number: 1001,
          name: 'John',
          lastName: 'Doe',
          dateOfBirth: DateTime(1990, 1, 1),
          notes: 'Test notes',
        ),
      ];
      when(mockRepo.searchPatientByName('John'))
          .thenAnswer((_) async => samplePatients);

      // Act
      await notifier.searchPatientsByName('John');

      // Assert
      expect(notifier.state.patients, samplePatients);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
    });

    test('searchPatientsByName handles errors gracefully', () async {
      // Arrange
      when(mockRepo.searchPatientByName('John'))
          .thenThrow(Exception('Search Error'));

      // Act
      await notifier.searchPatientsByName('John');

      // Assert
      expect(notifier.state.isLoading, false);
      expect(
          notifier.state.errorMessage, contains('Failed to search patients'));
      expect(notifier.state.patients, isEmpty);
    });
  });
}
