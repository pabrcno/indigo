import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/utils/bmi.dart';

void main() {
  group('calculateBMI', () {
    test('calculates BMI correctly for valid height and weight', () {
      final bmi = calculateBMI(heightInCM: 180, weightInKG: 75);
      expect(bmi, closeTo(23.15, 0.01));
    });

    test('throws an error when height is zero', () {
      expect(() => calculateBMI(heightInCM: 0, weightInKG: 75),
          throwsA(isA<Exception>()));
    });

    test('throws an error when weight is zero', () {
      expect(() => calculateBMI(heightInCM: 180, weightInKG: 0),
          throwsA(isA<Exception>()));
    });

    test('calculates BMI correctly for edge case values', () {
      final bmi = calculateBMI(heightInCM: 150, weightInKG: 45);
      expect(bmi, closeTo(20.0, 0.01));
    });
  });

  group('getBMICategory', () {
    test('returns "Bajo peso" for BMI less than 18.5', () {
      expect(getBMICategory(18.4), 'Bajo peso');
      expect(getBMICategory(10), 'Bajo peso');
    });

    test('returns "En buen estado" for BMI between 18.5 and 24.9', () {
      expect(getBMICategory(18.5), 'En buen estado');
      expect(getBMICategory(22), 'En buen estado');
      expect(getBMICategory(24.9), 'En buen estado');
    });

    test('returns "Sobrepeso" for BMI between 25 and 29.9', () {
      expect(getBMICategory(25), 'Sobrepeso');
      expect(getBMICategory(27), 'Sobrepeso');
      expect(getBMICategory(29.9), 'Sobrepeso');
    });

    test('returns "Obesidad" for BMI 30 and above', () {
      expect(getBMICategory(30), 'Obesidad');
      expect(getBMICategory(35), 'Obesidad');
      expect(getBMICategory(40), 'Obesidad');
    });
  });

  group('getBMILabelColor', () {
    test('returns blue color for BMI less than 18.5', () {
      expect(getBMILabelColor(18.4), Colors.blue);
    });

    test('returns green color for BMI between 18.5 and 24.9', () {
      expect(getBMILabelColor(18.5), Colors.green);
      expect(getBMILabelColor(22), Colors.green);
      expect(getBMILabelColor(24.9), Colors.green);
    });

    test('returns orange color for BMI between 25 and 29.9', () {
      expect(getBMILabelColor(25), Colors.orange);
      expect(getBMILabelColor(27), Colors.orange);
      expect(getBMILabelColor(29.9), Colors.orange);
    });

    test('returns red color for BMI 30 and above', () {
      expect(getBMILabelColor(30), Colors.red);
      expect(getBMILabelColor(35), Colors.red);
    });
  });

  group('calculateIndicatorPosition', () {
    const double barWidth = 200.0; // Example bar width

    test('returns 0 when BMI is less than or equal to minBMI', () {
      expect(calculateIndicatorPosition(4.0, barWidth), 0.0);
      expect(calculateIndicatorPosition(5.0, barWidth), 0.0);
    });

    test('returns barWidth when BMI is greater than or equal to maxBMI', () {
      expect(calculateIndicatorPosition(40.0, barWidth), barWidth);
      expect(calculateIndicatorPosition(45.0, barWidth), barWidth);
    });

    test('calculates position correctly within range', () {
      final position = calculateIndicatorPosition(22.5, barWidth);
      // Expected position calculation
      // ((22.5 - 5) / (40 - 5)) * barWidth
      const expectedPosition = ((22.5 - 5) / (35)) * barWidth;
      expect(position, closeTo(expectedPosition, 0.001));
    });

    test('calculates position correctly at mid BMI', () {
      final position = calculateIndicatorPosition(22.5, barWidth);
      expect(position, closeTo(100.0, 0.1)); // Approximately half of barWidth
    });
  });
}
