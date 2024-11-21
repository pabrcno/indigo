import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/shadow.dart';

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
      padding:
          const EdgeInsets.symmetric(vertical: standardSpacing, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [standardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: smallSpacing),
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
          const SizedBox(height: smallSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: standardSpacing,
                ),
              ),
              Text(
                '${value.toStringAsFixed(1)} $unit',
                style: const TextStyle(
                  fontSize: standardSpacing,
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
