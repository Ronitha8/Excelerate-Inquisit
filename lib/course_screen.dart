import 'package:flutter/material.dart';
import 'course_detail_screen.dart';

class CourseScreen extends StatelessWidget {
  final List<Map<String, String>> programs = [
    {
      'title': 'Artificial Intelligence',
      'description': 'Explore the future with AI and machine learning.',
      'image': 'assets/images/ai.jpg',
    },
    {
      'title': 'Data Science',
      'description': 'Learn data analysis, visualization, and Python.',
      'image': 'assets/images/data_science.jpg',
    },
    {
      'title': 'Cybersecurity',
      'description': 'Protect systems and secure networks from threats.',
      'image': 'assets/images/cyber_security.jpg',
    },
  ];

  CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Programs'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 4,
            child: Column(
              children: [
                Image.asset(
                  program['image']!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program['title']!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(program['description']!),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to detail screen and pass the selected program map.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailScreen(program: program),
                              ),
                            );
                          },
                          child: const Text('View Details'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
