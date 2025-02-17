import 'package:flutter/material.dart';

class LapsRecordWidget extends StatefulWidget {
  final Function(int) onValueChanged;
  const LapsRecordWidget({super.key, required this.onValueChanged});

  @override
  State<LapsRecordWidget> createState() => _LapsRecordWidgetState();
}

class _LapsRecordWidgetState extends State<LapsRecordWidget> {
  int _laps = 0;

  void _incrementLaps() {
    setState(() {
      _laps++;
    });
    widget.onValueChanged(_laps);
  }

  void _decrementLaps() {
    setState(() {
      if (_laps > 0) {
        _laps--;
      }
    });
    widget.onValueChanged(_laps);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          key: Key('Remove laps'),
          icon: Icon(Icons.remove),
          onPressed: _decrementLaps,
        ),
        Text('Laps ${_laps}'),
        IconButton(
          key: Key('Increase laps'),
          icon: Icon(Icons.add),
          onPressed: _incrementLaps,
        ),
      ],
    );
  }
}
