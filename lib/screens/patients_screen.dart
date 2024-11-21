import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/widgets/paddings.dart';
import 'package:indigo/providers/patient/patients_notifier_provider.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Fetch all patients when the screen loads
    Future.microtask(() {
      ref.read(patientsNotifierProvider.notifier).fetchAllPatients();
    });
  }

  void _onSearchChanged(String value, Function(String) onSearch) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      onSearch(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(patientsNotifierProvider);
    final notifier = ref.read(patientsNotifierProvider.notifier);

    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        margin: kPadding,
        padding: kPadding,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with search
            Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) =>
                      _onSearchChanged(value, notifier.searchPatientsByName),
                  decoration: InputDecoration(
                    hintText: 'Buscar Paciente por Nombre',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFFF5F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            // Table Header Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Número',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4263EB),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Nombre',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4263EB),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Apellido',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4263EB),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4263EB),
                      ),
                    ),
                  ),
                  if (!isSmallScreen) // Hide "Aclaraciones" on small screens
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Aclaraciones',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4263EB),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),
            // Table Rows Section
            if (state.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state.errorMessage != null)
              Expanded(
                child: Center(
                  child: Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.patients.length, // Dynamic row count
                  itemBuilder: (context, index) {
                    final patient = state.patients[index];
                    final isHovered = ValueNotifier<bool>(false);

                    return MouseRegion(
                      onEnter: (_) => isHovered.value = true,
                      onExit: (_) => isHovered.value = false,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isHovered,
                        builder: (context, hovered, child) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/patientProfile',
                                  arguments: patient,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: hovered
                                      ? const Color(
                                          0xFFF3E9FE) // Light purple hover
                                      : (index % 2 == 0
                                          ? Colors.white
                                          : const Color(
                                              0xFFF5F7FB)), // Alternating colors
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('${patient.number}'),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(patient.name),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(patient.lastName),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text('#${patient.id}'),
                                    ),
                                    if (!isSmallScreen) // Hide notes on small screens
                                      Expanded(
                                        flex: 2,
                                        child: Text(patient.notes ?? '-'),
                                      ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
