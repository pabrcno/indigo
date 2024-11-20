import 'package:flutter/material.dart';

class RulerWidget extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final Color backgroundColor;

  const RulerWidget({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              // Ruler lines
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  11,
                  (index) => Container(
                    height: index == 5 ? 30 : 15,
                    width: 2,
                    color:
                        index == 5 ? Colors.red : Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              // Highlighted line for the value
              Positioned(
                bottom: 0,
                child: Container(
                  width: 2,
                  height: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${value.toStringAsFixed(1)} $unit',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
