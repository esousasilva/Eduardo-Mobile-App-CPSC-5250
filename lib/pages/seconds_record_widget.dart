import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondsRecordWidget extends StatefulWidget {
  final Function(Duration) onValueChanged;
  const SecondsRecordWidget({super.key, required this.onValueChanged});

  @override
  State<SecondsRecordWidget> createState() => _SecondsRecordWidgetState();
}

class _SecondsRecordWidgetState extends State<SecondsRecordWidget> {
  final Stopwatch chronometer = Stopwatch();
  Duration elapsed = Duration.zero;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(microseconds: 100), (timer) {
      if(chronometer.isRunning) {
        setState(() {
          elapsed = chronometer.elapsed;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTime(){
    setState(() {
      if(!chronometer.isRunning){
        chronometer.reset();
        chronometer.start();
      }
    });
    
  }

  void _stopTimer() {
    setState(() {
      chronometer.stop();
      elapsed = chronometer.elapsed;
    });
    widget.onValueChanged(elapsed);
  }

  void _resetTimer() {
    setState(() {
      if(!chronometer.isRunning){
        chronometer.reset();
        elapsed = Duration.zero;
      }
    });
    widget.onValueChanged(elapsed);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text ('Elapsed Time: ${elapsed.inSeconds}'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _startTime,
              child: const Text('Start'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: _stopTimer,
                child: const Text('Stop')
            ),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: _resetTimer,
                child: const Text('Reset Timer')
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}
