import 'package:flutter/material.dart';

class PlansCard extends StatelessWidget {
  const PlansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensure Column shrinks to its content
        children: [
          // Header Section
          const Text(
            'Planes Activos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // List of Plans
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200), // Limit height
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3, // Example number of plans
              itemBuilder: (context, index) => ListTile(
                title: Text('Plan ${index + 1}'),
                subtitle: const Text('Details of the plan'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Create Plan Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Crear Nuevo Plan',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
