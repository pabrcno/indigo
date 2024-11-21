import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/colors.dart';
import 'package:indigo/presentation/constants/spacings.dart';

import 'package:indigo/presentation/widgets/shadow.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 1100;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: standardSpacing,
          vertical: isWideScreen ? 0 : standardSpacing),
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(standardSpacing),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: standardSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                              child: Text(
                            'Tareas asignadas recientemente',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [standardShadow]),
                            child: const Text(
                              '62',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: darkPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ver todo',
                          style: TextStyle(color: Colors.white),
                        )),
                    const _TaskCounter(label: 'Usuarios'),
                    const SizedBox(height: smallSpacing),
                    const _TaskCounter(label: 'Mensajes'),
                    const SizedBox(height: smallSpacing),
                    const _TaskCounter(label: 'Seguimientos'),
                  ],
                ),
              ),
              if (isWideScreen)
                const SizedBox(
                  width: standardSpacing * 2,
                ),
              if (isWideScreen)
                Padding(
                  padding: const EdgeInsets.only(top: standardSpacing),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/coach.png",
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskCounter extends StatelessWidget {
  final String label;

  const _TaskCounter({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: standardSpacing, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(smallSpacing)),
            boxShadow: [standardShadow]),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.blue, darkPurple])),
              child: Text(
                label[0], // First letter of the label
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: smallSpacing),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
