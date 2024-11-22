import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';

class BodyMetricsCard extends StatelessWidget {
  final String label;
  final double value;
  final double previousValue;

  const BodyMetricsCard({
    super.key,
    required this.label,
    required this.value,
    required this.previousValue,
  });

  @override
  Widget build(BuildContext context) {
    final Color arrowColor;
    final IconData arrowIcon;

    if (value > previousValue) {
      arrowColor = Colors.red;
      arrowIcon = Icons.arrow_upward;
    } else if (value < previousValue) {
      arrowColor = Colors.green;
      arrowIcon = Icons.arrow_downward;
    } else {
      arrowColor = Colors.grey;
      arrowIcon = Icons.remove; // Neutral/stable indicator
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: standardSpacing, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Metric label
          Text(
            label,
            key: const Key('metricLabel'),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: standardSpacing),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toStringAsFixed(1),
                key: const Key('metricValue'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: smallSpacing),
              Icon(
                arrowIcon,
                key: const Key('metricArrow'),
                color: arrowColor,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
