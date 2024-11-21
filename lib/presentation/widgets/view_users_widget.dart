import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/shadow.dart';

class ViewUsersWidget extends StatelessWidget {
  const ViewUsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // List of initials and their colors
    final List<Map<String, dynamic>> avatars = [
      {'initial': 'R', 'color': Colors.blue.shade300},
      {'initial': 'T', 'color': Colors.green},
      {'initial': 'B', 'color': Colors.purple},
      {'initial': 'L', 'color': Colors.cyan},
    ];

    return Container(
      padding: const EdgeInsets.all(standardSpacing),
      decoration: BoxDecoration(
        color: Colors.white, // Optional: Background color
        borderRadius: BorderRadius.circular(standardSpacing),
        boxShadow: [standardShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Overlapping Avatars
          SizedBox(
            height: 40, // Fixed height for the stack
            width: 100, // Adjust width based on number of circles and overlap
            child: Stack(
              children: avatars.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> avatar = entry.value;

                return Positioned(
                  left: index * 20.0, // Overlapping offset
                  child: CircleAvatar(
                    radius: standardSpacing,
                    backgroundColor: avatar['color'],
                    child: Text(
                      avatar['initial'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // "Ver usuarios" Button
          TextButton(onPressed: () {}, child: const Text('Ver usuarios')),
        ],
      ),
    );
  }
}
