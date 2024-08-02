import 'package:flutter/material.dart';
import 'habit_tracking_page.dart';
import 'sleep_tracking_page.dart';
import 'motivation_reminders_page.dart';
import 'focus_page.dart';

void main() {
  runApp(DailyDoseApp());
}

class DailyDoseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Dose',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black87),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Dose',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildCategoryCard(context, 'Alışkanlık Takibi', Icons.track_changes, Colors.blue[100]!, HabitTrackingPage()),
                  _buildCategoryCard(context, 'Uyku Takibi', Icons.bedtime, Colors.cyan[200]!, SleepTrackingPage()),
                  _buildCategoryCard(context, 'Motivasyon ve Hatırlatıcılar', Icons.notifications, Colors.purpleAccent[100]!, MotivationRemindersPage()),
                  _buildCategoryCard(context, 'Odaklanma', Icons.center_focus_strong, Colors.lime[300]!, FocusPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.black54),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
