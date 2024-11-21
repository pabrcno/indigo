import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/paddings.dart';

class BMIIndicator extends StatelessWidget {
  final double bmiValue;

  const BMIIndicator({
    super.key,
    required this.bmiValue,
  });

  @override
  Widget build(BuildContext context) {
    // Determine BMI category and status
    final bmiCategory = _getBMICategory(bmiValue);
    final bmiLabelColor = _getBMILabelColor(bmiValue);

    return Container(
      padding: kPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: smallSpacing,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Índice de masa corporal (IMC)',
            style: TextStyle(
              fontSize: standardSpacing,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: smallSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bmiValue.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: bmiLabelColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  bmiCategory,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: standardSpacing),
          LayoutBuilder(builder: (context, constraints) {
            final barWidth = constraints.maxWidth;

            return Stack(
              children: [
                // Gradient bar
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue, // Blue for underweight
                        Colors.green, // Green for normal
                        Colors.yellow, // Yellow for overweight
                        Colors.red, // Red for obesity
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // BMI indicator
                Positioned(
                  left: _calculateIndicatorPosition(bmiValue, barWidth),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: smallSpacing),
          // Labels for the bar
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('15', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('18.5', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('25', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('30', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('40', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // Helper to determine the BMI category
  String _getBMICategory(double bmi) {
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
  Color _getBMILabelColor(double bmi) {
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
  double _calculateIndicatorPosition(double bmi, double barWidth) {
    const double minBMI = 5;
    const double maxBMI = 40;

    if (bmi <= minBMI) return 0;
    if (bmi >= maxBMI) return barWidth;

    return ((bmi - minBMI) / (maxBMI - minBMI)) * barWidth;
  }
}
