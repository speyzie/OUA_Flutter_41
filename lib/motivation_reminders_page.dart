import 'package:flutter/material.dart';
import 'dart:math';

class MotivationRemindersPage extends StatefulWidget {
  @override
  _MotivationRemindersPageState createState() => _MotivationRemindersPageState();
}

class _MotivationRemindersPageState extends State<MotivationRemindersPage> {
  final List<String> _messages = [
    "Başarı, azim ve çaba gerektirir.",
    "Hayallerinin peşinden gitmek cesaret ister.",
    "Küçük adımlar büyük başarıların temelidir.",
    "Her gün kendini biraz daha geliştir.",
    "Zorluklar, başarının anahtarıdır.",
    "Kendine inan, her şey mümkün.",
    "Bugün, geleceğin için en önemli gündür.",
    "Başarı, tutkunun ve çalışmanın birleşimidir.",
  ];

  String _currentMessage = '';

  @override
  void initState() {
    super.initState();
    _currentMessage = _getRandomMessage();
  }

  String _getRandomMessage() {
    final random = Random();
    final index = random.nextInt(_messages.length);
    return _messages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motivasyon ve Hatırlatmalar'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
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
                  Icon(
                    Icons.mood,
                    color: Colors.deepPurple,
                    size: 60,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _currentMessage,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center, // Doğru kullanım
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentMessage = _getRandomMessage();
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Yeni Mesaj'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Doğru kullanım
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
