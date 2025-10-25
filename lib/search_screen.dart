import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'main.dart';
import 'course_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<dynamic> allCourses = [];
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
      if (!mounted) return;
      setState(() {
        allCourses = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Failed to load courses: $e';
        isLoading = false;
      });
    }
  }

  List<dynamic> get filteredCourses {
    if (searchQuery.isEmpty) return allCourses;
    return allCourses
        .where((c) =>
            c['title'] != null &&
            c['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: Text(error!))
                : Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: kHeaderBackground,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new,
                                      color: kPrimaryText),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Search Courses",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) =>
                                  setState(() => searchQuery = value),
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Search by course name...",
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon:
                                    const Icon(Icons.search, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Results
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: filteredCourses.length,
                          itemBuilder: (context, index) {
                            final course = filteredCourses[index];
                            return _buildCourseItem(
                              title: course['title'] ?? 'Unknown Course',
                              duration: course['duration'] ?? 'N/A',
                              level: course['level'] ?? 'N/A',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CourseDetailScreen(program: course),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  // نفس تأثير الضغط الموجود في الـ Account Screen
  Widget _buildCourseItem({
    required String title,
    required String duration,
    required String level,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: kBottomNavActive.withOpacity(0.2),
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kHeaderBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.book, color: kBottomNavActive, size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryText,
                    ),
                  ),
                  Text(
                    'Duration: $duration | Level: $level',
                    style: const TextStyle(
                      color: kSecondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: kSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
