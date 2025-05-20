import 'package:flutter/material.dart';

class PersonEntry {
  String name;
  String amount;
  final TextEditingController nameController;
  final TextEditingController amountController;

  PersonEntry({this.name = '', this.amount = ''})
    : nameController = TextEditingController(text: name),
      amountController = TextEditingController(text: amount);

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}
