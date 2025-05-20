import 'package:flutter/material.dart';
import 'person_entry.dart';

class ReceiptBreakdown extends StatelessWidget {
  final double totalBill;
  final List<PersonEntry> people;
  final double outstanding;

  const ReceiptBreakdown({
    super.key,
    required this.totalBill,
    required this.people,
    required this.outstanding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOverpaid = outstanding < 0;
    final double displayOutstanding = outstanding.abs();

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Breakdown'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Bill: R${totalBill.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32, thickness: 2),
            Expanded(
              child: ListView.separated(
                itemCount: people.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final person = people[index];
                  final amount = double.tryParse(person.amount) ?? 0.0;

                  return ListTile(
                    title: Text(
                      person.name.isNotEmpty ? person.name : 'Unnamed',
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      'R${amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 32, thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOverpaid ? 'Tip:' : 'Outstanding:',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R${displayOutstanding.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOverpaid ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
