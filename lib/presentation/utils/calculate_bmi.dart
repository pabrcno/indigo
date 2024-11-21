import 'dart:math';

double calculateBMI({required double heightInCM, required double weightInKG}) =>
    weightInKG / pow(heightInCM / 100, 2);
