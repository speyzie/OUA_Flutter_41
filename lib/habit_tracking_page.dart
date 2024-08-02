import 'package:flutter/material.dart';

class HabitTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alışkanlık Takibi'),
        backgroundColor: Colors.green,
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
                  _buildCategoryCard(context, 'Egzersiz Takibi', Icons.fitness_center, Colors.blue[100]!, _buildExerciseContent()),
                  _buildCategoryCard(context, 'Okuma Takibi', Icons.book, Colors.red[100]!, _buildReadingContent()),
                  _buildCategoryCard(context, 'Meditasyon Takibi', Icons.self_improvement, Colors.purple[100]!, _buildMeditationContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, Widget content) {
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
            MaterialPageRoute(builder: (context) => HabitDetailPage(title: title, content: content)),
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

  Widget _buildExerciseContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Egzersiz Takibi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          HabitTracker(),
        ],
      ),
    );
  }

  Widget _buildReadingContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Okuma Takibi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          HabitTracker(),
        ],
      ),
    );
  }

  Widget _buildMeditationContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Meditasyon Takibi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          HabitTracker(),
        ],
      ),
    );
  }
}

class HabitDetailPage extends StatelessWidget {
  final String title;
  final Widget content;

  HabitDetailPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: content,
    );
  }
}

class HabitTracker extends StatefulWidget {
  @override
  _HabitTrackerState createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  List<bool> _completedDays = List<bool>.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _completedDays[index] = !_completedDays[index];
            });
          },
          child: Card(
            color: _completedDays[index] ? Colors.green : Colors.grey[200],
            child: Center(
              child: Text('${index + 1}', style: TextStyle(fontSize: 16)),
            ),
          ),
        );
      },
    );
  }
}
