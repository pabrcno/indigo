import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/db/patient/i_patient_repo.dart';
import 'package:indigo/db/patient/patient_repo_provider.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import 'patient_provider_test.mocks.dart';

@GenerateMocks([IPatientRepo])
void main() {
  late ProviderContainer container;
  late MockIPatientRepo mockRepo;

  setUp(() {
    mockRepo = MockIPatientRepo();
    container = ProviderContainer(
      overrides: [
        patientsRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);
  });

  group('PatientsRepository Tests', () {
    test('fetchAllPatients returns correct data', () async {
      // Arrange
      final samplePatients = [
        Patient(
          id: 1,
          number: 1001,
          name: 'John',
          lastName: 'Doe',
          dateOfBirth: DateTime(1990, 1, 1),
          notes: 'Sample note',
        ),
      ];
      when(mockRepo.getAllPatients()).thenAnswer((_) async => samplePatients);

      // Act
      final result =
          await container.read(patientsRepositoryProvider).getAllPatients();

      // Assert
      expect(result, samplePatients);
      verify(mockRepo.getAllPatients()).called(1);
    });

    test('fetchAllPatients handles errors', () async {
      // Arrange
      when(mockRepo.getAllPatients()).thenThrow(Exception('Fetch error'));

      // Act & Assert
      expect(
        () async =>
            await container.read(patientsRepositoryProvider).getAllPatients(),
        throwsA(isA<Exception>()),
      );
    });

    test('searchPatientByName returns correct data', () async {
      // Arrange
      final samplePatients = [
        Patient(
          id: 1,
          number: 1001,
          name: 'John',
          lastName: 'Doe',
          dateOfBirth: DateTime(1990, 1, 1),
          notes: 'Sample note',
        ),
      ];
      when(mockRepo.searchPatientByName('John'))
          .thenAnswer((_) async => samplePatients);

      // Act
      final result = await container
          .read(patientsRepositoryProvider)
          .searchPatientByName('John');

      // Assert
      expect(result, samplePatients);
      verify(mockRepo.searchPatientByName('John')).called(1);
    });

    test('searchPatientByName handles errors', () async {
      // Arrange
      when(mockRepo.searchPatientByName('John'))
          .thenThrow(Exception('Search error'));

      // Act & Assert
      expect(
        () async => await container
            .read(patientsRepositoryProvider)
            .searchPatientByName('John'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
