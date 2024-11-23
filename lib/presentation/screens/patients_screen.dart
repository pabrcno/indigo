import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/presentation/constants/colors.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/paddings.dart';
import 'package:indigo/providers/patient/patients_provider.dart';

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
      ref.read(patientsProvider.notifier).fetchAllPatients();
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
    final state = ref.watch(patientsProvider);
    final notifier = ref.read(patientsProvider.notifier);

    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    final columnHeaders = [
      {'label': 'Número', 'flex': 1},
      {'label': 'Nombre', 'flex': 2},
      {'label': 'Apellido', 'flex': 2},
      {'label': 'ID', 'flex': 1},
      if (!isSmallScreen) {'label': 'Aclaraciones', 'flex': 2},
    ];

    return Scaffold(
      body: Container(
        margin: kPadding,
        padding: kPadding,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(standardSpacing),
            topRight: Radius.circular(standardSpacing),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with search
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextField(
                key: const Key('search_field'),
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
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: standardSpacing,
            ),
            // Table Header Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: standardSpacing),
              child: Row(
                key: const Key('table_header'),
                children: columnHeaders
                    .map((header) => Expanded(
                          flex: header['flex'] as int,
                          child: Text(
                            header['label'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkPurple,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

            const Divider(height: 1, color: Colors.grey),
            // Table Rows Section
            Expanded(
              child: state.when(
                data: (patients) => ListView.builder(
                  key: const Key('patients_list'),
                  itemCount: patients.length, // Dynamic row count
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    final isHovered = ValueNotifier<bool>(false);

                    final patientData = [
                      {'value': '${patient.number}', 'flex': 1},
                      {'value': patient.name, 'flex': 2},
                      {'value': patient.lastName, 'flex': 2},
                      {'value': '#${patient.id}', 'flex': 1},
                      if (!isSmallScreen)
                        {'value': patient.notes ?? '-', 'flex': 2},
                    ];

                    return MouseRegion(
                      onEnter: (_) => isHovered.value = true,
                      onExit: (_) => isHovered.value = false,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isHovered,
                        builder: (context, hovered, child) {
                          return InkWell(
                            key: Key('patient_row_$index'),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/patientProfile',
                                arguments: patient,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: standardSpacing,
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
                                children: patientData
                                    .map((data) => Expanded(
                                          flex: data['flex'] as int,
                                          child: Text(data['value'] as String),
                                        ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                loading: () => const Center(
                  key: Key('loading_indicator'),
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  key: const Key('error_message'),
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
