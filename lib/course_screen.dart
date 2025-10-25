import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'course_detail_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState(); // fixed: public State<T> return type
}

class _CourseScreenState extends State<CourseScreen> {
  List<dynamic> programs = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final String response = await rootBundle.loadString('assets/courses.json');
      final List<dynamic> data = jsonDecode(response);
      if (!mounted) return; // guard against using context/setState after async gap
      setState(() {
        programs = data;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Courses loaded successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Failed to load courses: $e';
        isLoading = false;
      });
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  itemCount: programs.length,
                  itemBuilder: (context, index) {
                    final program = programs[index];
                    return Card(
                      margin: const EdgeInsets.all(12),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            program['image'] ?? 'assets/images/placeholder.jpg',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 180,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 50),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  program['title'] ?? 'Unknown Course',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  program['description'] ?? '',
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Duration: ${program['duration'] ?? 'N/A'} | Level: ${program['level'] ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Instructor: ${program['instructor'] ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CourseDetailScreen(program: program),
                                        ),
                                      );
                                    },
                                    child: const Text('View Details'),
                                  ),
                                ),
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