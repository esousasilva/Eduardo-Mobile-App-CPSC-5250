import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MilesRecordWidget extends StatefulWidget {
  final Function(double) onValueChanged;
  const MilesRecordWidget({super.key, required this.onValueChanged});

  @override
  State<MilesRecordWidget> createState() => _MilesRecordWidgetState();
}

class _MilesRecordWidgetState extends State<MilesRecordWidget> {
  double _currentMiles = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Select The Distance (Miles): ${_currentMiles.toInt()}',
        style: const TextStyle(fontSize: 16)
        ),
        Slider(
          value: _currentMiles,
          min: 1,
          max: 50,
          divisions: 50,
          label: _currentMiles.toInt().toString(),
          onChanged: (double value) {
            setState(() {
              _currentMiles = value;
            });
            widget.onValueChanged(_currentMiles);
          },
        )
      ],
    );
  }
}
