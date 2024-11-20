import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/providers/patient/patients_notifier_provider.dart';
import 'package:indigo/screens/patient_profile.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  PatientsScreenState createState() => PatientsScreenState();
}

class PatientsScreenState extends ConsumerState<PatientsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all patients when the screen loads
    Future.microtask(() {
      ref.read(patientsNotifierProvider.notifier).fetchAllPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(patientsNotifierProvider);
    final notifier = ref.read(patientsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.fetchAllPatients(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => notifier.searchPatientsByName(value),
              decoration: const InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (state.isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (state.errorMessage != null)
            Expanded(
              child: Center(
                child: Text('Error: ${state.errorMessage}'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.patients.length,
                itemBuilder: (context, index) {
                  final patient = state.patients[index];
                  return ListTile(
                    leading: Text('${patient.id}'),
                    title: Text(patient.name),
                    subtitle: Text('ID: #${patient.id}'),
                    onTap: () {
                      // Navigate to the PatientProfileScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientProfileScreen(
                            patientId: patient.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
