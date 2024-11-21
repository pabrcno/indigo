import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/providers/patient/patients_notifier_provider.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
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
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => notifier.searchPatientsByName(value),
            decoration: const InputDecoration(
              labelText: 'Buscar por nombre',
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Número',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Nombre',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Apellido',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('ID',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Aclaraciones',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: state.patients.map((patient) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${patient.number}')), // "Número"
                      DataCell(Text(patient.name)), // "Nombre"
                      DataCell(Text(patient.lastName)), // "Apellido"
                      DataCell(Text('#${patient.id}')), // "ID"
                      DataCell(Text(patient.notes ?? '-')), // "Aclaraciones"
                    ],
                    onSelectChanged: (_) {
                      Navigator.of(context).pushNamed(
                        '/patientProfile',
                        arguments: patient,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    ));
  }
}
