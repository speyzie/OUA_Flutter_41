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
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.grey,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.grey[800]),
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
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dengeli Bir Yaşam İçin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Sağlıklı beslenme, egzersiz, meditasyon ve uyku düzeni gibi konularda kişiselleştirilmiş tavsiyeler ve hedefler belirleyin. Gelişiminizi izleyin, motivasyonunuzu artırın ve sağlıklı alışkanlıklarınızı kalıcı hale getirin. Sağlıklı bir yaşam için yanınızdayız!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildCategoryCard(context, 'Alışkanlık Takibi', Icons.track_changes, Colors.green[100]!, HabitTrackingPage()),
                  _buildCategoryCard(context, 'Uyku Takibi', Icons.bedtime, Colors.green[200]!, SleepTrackingPage()),
                  _buildCategoryCard(context, 'Motivasyon ve Hatırlatıcılar', Icons.notifications, Colors.green[300]!, MotivationRemindersPage()),
                  _buildCategoryCard(context, 'Odaklanma', Icons.center_focus_strong, Colors.green[400]!, FocusPage()),
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
            Icon(icon, size: 48, color: Colors.green),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
