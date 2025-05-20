import 'package:flutter/material.dart';
import 'person_entry.dart';
import 'total_bill_card.dart';
import 'person_card.dart';
import 'tip_display.dart';
import 'receipt_breakdown.dart';

class ShareAccountPage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const ShareAccountPage({super.key, required this.onThemeToggle});

  @override
  ShareAccountPageState createState() => ShareAccountPageState();
}

class ShareAccountPageState extends State<ShareAccountPage> {
  final TextEditingController _totalBillController = TextEditingController();
  final List<PersonEntry> _people = [PersonEntry()];

  double get totalBill => double.tryParse(_totalBillController.text) ?? 0.00;

  double get totalContributed {
    return _people.fold(0.00, (sum, person) {
      return sum + (double.tryParse(person.amount) ?? 0.00);
    });
  }

  double get rawOutstanding => totalBill - totalContributed;

  double get outstanding => rawOutstanding < 0 ? 0.00 : rawOutstanding;

  double get tip => rawOutstanding < 0 ? rawOutstanding.abs() : 0.00;

  void _addPerson() {
    setState(() {
      _people.add(PersonEntry());
    });
  }

  void _removePerson(int index) {
    if (_people.length > 1) {
      setState(() {
        _people[index].dispose();
        _people.removeAt(index);
      });
    }
  }

  void _clearAll() {
    setState(() {
      _totalBillController.clear();
      for (var p in _people) {
        p.dispose();
      }
      _people.clear();
      _people.add(PersonEntry());
    });
  }

  @override
  void initState() {
    super.initState();
    _totalBillController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _totalBillController.dispose();
    for (var p in _people) {
      p.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Share'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            onPressed: _clearAll,
            icon: const Icon(Icons.refresh),
            tooltip: 'Clear All',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => ReceiptBreakdown(
                        totalBill: totalBill,
                        people: _people,
                        outstanding: rawOutstanding,
                      ),
                ),
              );
            },
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Show Receipt Breakdown',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TotalBillCard(
                controller: _totalBillController,
                outstanding: outstanding,
              ),
              if (tip > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TipDisplay(tipAmount: tip),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _people.length,
                  itemBuilder: (context, index) {
                    return PersonCard(
                      person: _people[index],
                      onRemove: () => _removePerson(index),
                      onAmountFormat: (formattedAmount) {
                        setState(() {
                          _people[index].amount = formattedAmount;
                          _people[index].amountController.text =
                              formattedAmount;
                        });
                      },
                      onAmountChange: (value) {
                        setState(() {
                          _people[index].amount = value;
                        });
                      },
                      onNameChange: (value) {
                        setState(() {
                          _people[index].name = value;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addPerson,
                  child: const Text(
                    '+ Add Person',
                    style: TextStyle(fontSize: 16),
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
