import 'package:flutter/material.dart';

class ConditionDropdown extends StatefulWidget {
  const ConditionDropdown({super.key});

  @override
  State<ConditionDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<ConditionDropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      isExpanded: true,
      hint: const Text('Select Condition'),
      items: const [
        DropdownMenuItem<String>(
          value: 'New',
          child: Text('New'),
        ),
        DropdownMenuItem<String>(
          value: 'Old',
          child: Text('Old'),
        ),
        DropdownMenuItem<String>(
          value: 'Not Specified',
          child: Text('Not Specified'),
        ),
      ],
    );
  }
}
