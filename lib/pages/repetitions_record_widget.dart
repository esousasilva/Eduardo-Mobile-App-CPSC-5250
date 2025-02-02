import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RepetitionUnitValues{
  five('5', 5),
  ten('10', 10),
  fifteen('15', 15),
  twenty('20', 20),
  twentyFive('25', 25),
  thirty('30', 30);

  const RepetitionUnitValues(this.label, this.unit);
  final String label;
  final int unit;
}

class RepetitionsRecordWidget extends StatefulWidget {
  const RepetitionsRecordWidget({super.key});

  @override
  State<RepetitionsRecordWidget> createState() => _RepetitionsRecordWidgetState();
}

class _RepetitionsRecordWidgetState extends State<RepetitionsRecordWidget> {
  final TextEditingController repetitionUnitController = TextEditingController();
  int? repetitionUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centers the dropdown
      children: [
        Text('Unit: Repetitions'),
        DropdownMenu(
          controller: repetitionUnitController,
          initialSelection: RepetitionUnitValues.five.label,
          dropdownMenuEntries: RepetitionUnitValues.values
              .map((unit) => DropdownMenuEntry(value: unit.label, label: unit.label))
              .toList(),
          onSelected: (value) {
            repetitionUnitController.text = value!;
          },
        ),
      ],
    );
  }
}