import 'package:flutter/material.dart';
import 'dart:async';

class SleepTrackingPage extends StatefulWidget {
  @override
  _SleepTrackingPageState createState() => _SleepTrackingPageState();
}

class _SleepTrackingPageState extends State<SleepTrackingPage> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<Duration> _sleepDurations = [];

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _sleepDurations.insert(0, _stopwatch.elapsed);
      if (_sleepDurations.length > 5) {
        _sleepDurations.removeLast();
      }
      _stopwatch.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uyku Takibi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Son Uyku Süresi:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _formatDuration(_stopwatch.elapsed),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _startTimer,
                  child: Text('Uyku Takibini Başlat'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _stopTimer : null,
                  child: Text('Uyku Takibini Durdur'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Son 5 Uyku Süresi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _sleepDurations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_formatDuration(_sleepDurations[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
