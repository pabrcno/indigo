import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(arrowIcon, color: arrowColor, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
