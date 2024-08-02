import 'package:flutter/material.dart';
import 'dart:math';

class MotivationRemindersPage extends StatefulWidget {
  @override
  _MotivationRemindersPageState createState() => _MotivationRemindersPageState();
}

class _MotivationRemindersPageState extends State<MotivationRemindersPage> {
  final List<Map<String, String>> _userReminders = [];

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

  void _addReminder(String title, String description) {
    setState(() {
      _userReminders.add({'title': title, 'description': description});
    });
  }

  void _removeReminder(int index) {
    setState(() {
      _userReminders.removeAt(index);
    });
  }

  Future<void> _showAddReminderDialog() async {
    String? title;
    String? description;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Hatırlatıcı Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(hintText: "Başlık"),
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(hintText: "Açıklama"),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ekle'),
              onPressed: () {
                if (title != null && description != null && title!.isNotEmpty && description!.isNotEmpty) {
                  _addReminder(title!, description!);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _userReminders.length,
                  itemBuilder: (context, index) {
                    final reminder = _userReminders[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          reminder['title']!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          reminder['description']!,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeReminder(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showAddReminderDialog,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Yeni Hatırlatıcı Ekle'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Container(
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
                      textAlign: TextAlign.center,
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
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
