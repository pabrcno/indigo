import 'dart:math';

import 'package:flutter/material.dart';

double calculateBMI({required double heightInCM, required double weightInKG}) {
  if (heightInCM <= 0) {
    throw Exception('Height must be greater than zero.');
  }
  if (weightInKG <= 0) {
    throw Exception('Weight must be greater than zero.');
  }
  return weightInKG / pow(heightInCM / 100, 2);
}

String getBMICategory(double bmi) {
  if (bmi < 18.5) {
    return 'Bajo peso';
  } else if (bmi >= 18.5 && bmi < 25) {
    return 'En buen estado';
  } else if (bmi >= 25 && bmi < 30) {
    return 'Sobrepeso';
  } else {
    return 'Obesidad';
  }
}

// Helper to get the label color based on BMI
Color getBMILabelColor(double bmi) {
  if (bmi < 18.5) {
    return Colors.blue;
  } else if (bmi >= 18.5 && bmi < 25) {
    return Colors.green;
  } else if (bmi >= 25 && bmi < 30) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

// Helper to calculate the indicator's position on the bar
double calculateIndicatorPosition(double bmi, double barWidth) {
  const double minBMI = 5;
  const double maxBMI = 40;

  if (bmi <= minBMI) return 0;
  if (bmi >= maxBMI) return barWidth;

  return ((bmi - minBMI) / (maxBMI - minBMI)) * barWidth;
}
