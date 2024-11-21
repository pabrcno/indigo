import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/colors.dart';
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
              Container(
                width: double.infinity, // Make header full width
                padding: const EdgeInsets.all(smallSpacing),
                decoration: BoxDecoration(
                  color: darkPurple, // Blue background for header
                  borderRadius: BorderRadius.circular(smallSpacing),
                ),
                child: const Text(
                  'Planes Activos',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text
                  ),
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
                      title: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8.0,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Camila Rodríguez', // Replace dynamically if needed
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Plan de Entrenamiento de Fuerza', // Replace dynamically if needed
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              '(4 días/semana)',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              width: standardSpacing,
                            ),
                            Text(
                              'Activo',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background
                    foregroundColor: darkPurple, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Rounded corners
                    ),
                    side: const BorderSide(
                        color: darkPurple, width: 1.5), // Optional: Border
                  ),
                  onPressed: () => {
                    // Handle create plan logic
                  },
                  child: const Text(
                    'Crear Nuevo Plan',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
