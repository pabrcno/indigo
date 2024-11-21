import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/shadow.dart';

class PlansCard extends StatelessWidget {
  const PlansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 375,
        ),
        child: Container(
            padding: const EdgeInsets.all(standardSpacing),
            decoration: BoxDecoration(
              color: Colors.white, // Optional: Background color
              borderRadius: BorderRadius.circular(standardSpacing),
              boxShadow: [standardShadow],
            ),
            child: // Constrained List of Plans
                ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  const Text(
                    'Planes Activos',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: standardSpacing),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3, // Example number of plans
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          title: Text('Plan ${index + 1}'),
                          subtitle: const Text('Details of the plan'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                          ),
                          onTap: () {
                            // Handle tap logic here
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: standardSpacing),

                  // Create Plan Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle create plan logic
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: const Text(
                        'Crear Nuevo Plan',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
