import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/colors.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/paddings.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: standardSpacing),
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(8.0),
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
                      padding:
                          const EdgeInsets.symmetric(vertical: standardSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tareas asignadas recientemente',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '62',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: lightPurple,
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
                    const _TaskCounter(label: 'Usuarios', count: 20),
                    const SizedBox(height: smallSpacing),
                    const _TaskCounter(label: 'Mensajes', count: 15),
                    const SizedBox(height: smallSpacing),
                    const _TaskCounter(label: 'Seguimientos', count: 27),
                  ],
                ),
              ),
              const SizedBox(
                width: standardSpacing * 4,
              ),
              // Image Section
              Padding(
                padding: const EdgeInsets.only(top: standardSpacing),
                child: Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/coach.png",
                      fit: BoxFit.contain,
                    ),
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
  final int count;

  const _TaskCounter({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kSmallPadding,
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
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }
}
