import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'person_entry.dart';

class PersonCard extends StatelessWidget {
  final PersonEntry person;
  final VoidCallback onRemove;
  final ValueChanged<String> onAmountChange;
  final ValueChanged<String> onNameChange;
  final ValueChanged<String> onAmountFormat;

  const PersonCard({
    super.key,
    required this.person,
    required this.onRemove,
    required this.onAmountChange,
    required this.onAmountFormat,
    required this.onNameChange,
  });

  String formatAmount(String value) {
    final parsed = double.tryParse(value);
    return parsed != null ? parsed.toStringAsFixed(2) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: person.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: onNameChange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    final formatted = formatAmount(
                      person.amountController.text,
                    );
                    onAmountFormat(formatted);
                  }
                },
                child: TextField(
                  controller: person.amountController,
                  decoration: const InputDecoration(labelText: 'Amount (R)'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: onAmountChange,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Remove Person',
            ),
          ],
        ),
      ),
    );
  }
}
