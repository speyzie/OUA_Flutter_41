import 'package:flutter/material.dart';
import 'dart:async';

class FocusPage extends StatefulWidget {
  @override
  _FocusPageState createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  Timer? _timer;
  int _start = 0;
  int _current = 0;
  bool _isTimerRunning = false;
  bool _isPaused = false;
  final TextEditingController _controller = TextEditingController();

  void startTimer() {
    setState(() {
      _current = _start * 60; // dakika olarak girilen süreyi saniyeye çevir
      _isTimerRunning = true;
      _isPaused = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_current > 0) {
          _current--;
        } else {
          _timer?.cancel();
          _isTimerRunning = false;
          _isPaused = false;
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      _timer?.cancel();
      _isTimerRunning = false;
      _isPaused = true;
    });
  }

  void continueTimer() {
    setState(() {
      _isTimerRunning = true;
      _isPaused = false;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_current > 0) {
          _current--;
        } else {
          _timer?.cancel();
          _isTimerRunning = false;
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _timer?.cancel();
      _isTimerRunning = false;
      _isPaused = false;
      _current = 0;
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odaklanma'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green[100], // Ekranın arka plan rengini yeşil yapıyoruz
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!_isTimerRunning && !_isPaused) ...[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.green[300], // Daha açık yeşil ton
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kaç dakika odaklanmak istersin?',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Süre (dakika)',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _start = int.tryParse(value) ?? 0;
                            if (_start > 0) startTimer();
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _start = int.tryParse(_controller.text) ?? 0;
                            if (_start > 0) startTimer();
                          });
                        },
                        child: Text('Başlat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Renk güncellendi
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (_isTimerRunning || _isPaused) ...[
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.green[300], // Daha açık yeşil ton
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Geri Sayım',
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${(_current ~/ 60).toString().padLeft(2, '0')}:${(_current % 60).toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          if (_isPaused) ...[
                            ElevatedButton(
                              onPressed: continueTimer,
                              child: Text('Devam Et'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, // Renk güncellendi
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                textStyle: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                          ElevatedButton(
                            onPressed: stopTimer,
                            child: Text('Durdur'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Renk güncellendi
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: resetTimer,
                            child: Text('Sıfırla'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey, // Renk güncellendi
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
