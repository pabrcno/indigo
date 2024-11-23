import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';

void showEditMetricsModal({
  required BuildContext context,
  required String fieldLabel,
  required Future<void> Function(double value) onSave,
}) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(standardSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                key: const Key('editMetricsModalTitle'),
                'Crea una nueva entrada en $fieldLabel',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                key: const Key('editMetricsModalTextField'),
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: fieldLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('editMetricsModalSaveButton'),
                onPressed: () async {
                  final value = double.tryParse(controller.text);

                  if (value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Invalid value. Please enter a valid number.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  try {
                    await onSave(value);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Metric added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Close the dialog
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Failed to save metric: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
