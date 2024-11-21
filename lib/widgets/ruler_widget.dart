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
          const SizedBox(height: 8),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  11,
                  (index) {
                    final opacity = 1.0 - (index - 5).abs() / 10.0;
                    return Container(
                      height: index == 5 ? 20 : 12,
                      width: 2,
                      color: index == 5
                          ? Colors.red
                          : Colors.black.withOpacity(opacity),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '${value.toStringAsFixed(1)} $unit',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
