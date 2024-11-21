import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tareas asignadas recientemente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('Ver todo')),
            ],
          ),

          // Task Counters Section
          const SizedBox(height: 16),
          const Column(
            children: [
              _TaskCounter(label: 'Usuarios', count: 20),
              SizedBox(height: 8),
              _TaskCounter(label: 'Mensajes', count: 15),
              SizedBox(height: 8),
              _TaskCounter(label: 'Seguimientos', count: 27),
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
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: Text(
            label[0], // First letter of the label
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
