import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, String> program;

  const CourseDetailScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final imagePath = program['image'] ?? '';
    final title = program['title'] ?? '';
    final description = program['description'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title.isNotEmpty ? title : 'Course Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath.isNotEmpty)
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 250,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 64),
              ),
            )
          else
            Container(
              height: 250,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 64),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
