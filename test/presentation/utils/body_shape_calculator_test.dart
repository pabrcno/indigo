import 'package:flutter_test/flutter_test.dart';
import 'package:indigo/presentation/utils/determine_body_shape.dart';

void main() {
  group('determineBodyShape', () {
    test('returns "Triángulo invertido" when chest is largest', () {
      expect(determineBodyShape(100, 80, 90), "Triángulo invertido");
      expect(determineBodyShape(90, 70, 80), "Triángulo invertido");
    });

    test('returns "Forma de pera" when hips are largest', () {
      expect(determineBodyShape(80, 70, 100), "Forma de pera");
      expect(determineBodyShape(85, 75, 90), "Forma de pera");
    });

    test('returns "Forma rectangular" for other proportions', () {
      expect(determineBodyShape(85, 80, 85), "Forma rectangular");
      expect(determineBodyShape(90, 80, 90), "Forma rectangular");
    });
  });
}
