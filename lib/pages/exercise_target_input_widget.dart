import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseTargetInputWidget extends StatefulWidget {
  final Function(int) onValueChanged;

  const ExerciseTargetInputWidget({super.key, required this.onValueChanged});

  @override
  State<ExerciseTargetInputWidget> createState() => _ExerciseTargetInputWidgetState();
}

class _ExerciseTargetInputWidgetState extends State<ExerciseTargetInputWidget> {
  TextEditingController targetInputController = TextEditingController();
  int _targetInput = 0;

  @override
  void initState() {
    super.initState();
    targetInputController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    targetInputController.removeListener(_handleTextChange);
    targetInputController.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    String input = targetInputController.text;
    int? parsedValue = int.tryParse(input); // Safely parse the number

    if (parsedValue != null) {
      setState(() {
        _targetInput = parsedValue;
      });
      widget.onValueChanged(_targetInput);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            maxLength: 3,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            controller: targetInputController,
            decoration: InputDecoration(labelText: "Enter Target"),
          ),
        ),
      ],
    );
  }
}
