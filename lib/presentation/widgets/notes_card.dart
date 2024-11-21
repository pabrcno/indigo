import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/shadow.dart';

class NotesCard extends StatelessWidget {
  final String notes;
  final VoidCallback onCreate;

  const NotesCard({
    super.key,
    required this.notes,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EC), // Light orange background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [standardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "NOTAS" tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE7C3), // Orange tag background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'NOTAS',
              style: theme.textTheme.titleSmall?.copyWith(
                color: const Color(0xFFDAA520), // Darker orange text
              ),
            ),
          ),
          const SizedBox(height: smallSpacing),
          // Notes text
          Text(
            notes,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: standardSpacing),
          // Add comments button
          InkWell(
            onTap: onCreate,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: standardSpacing),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFFA500), // Dashed border color
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),

                color: const Color(0xFFFFF7EC), // Same background color
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.add, color: Color(0xFFFFA500)),
                      const SizedBox(width: smallSpacing),
                      Text(
                        'Añadir comentarios',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFFFA500),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: standardSpacing,
                    color: Color(0xFFFFA500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
