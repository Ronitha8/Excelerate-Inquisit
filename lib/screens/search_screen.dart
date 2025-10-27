import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/models/program_model.dart';
import 'package:excelerate_inquisit/screens/program_details_page.dart';
import 'package:excelerate_inquisit/screens/home_screen.dart';
import 'package:excelerate_inquisit/screens/course_screen.dart';
import 'package:excelerate_inquisit/screens/message_screen.dart';
import 'package:excelerate_inquisit/screens/account_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<Program> allCourses = [];
  String selectedCategory = 'All';
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
        allCourses = data.map((json) => Program.fromJson(json)).toList();
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

  List<Program> get filteredCourses {
    if (searchQuery.isEmpty && selectedCategory == 'All') return allCourses;
    return allCourses.where((course) {
      final matchesSearch = course.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'All' ||
          (course.role ?? '').toLowerCase().contains(selectedCategory.toLowerCase());
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: Text(error!, style: GoogleFonts.poppins(color: kPrimaryText)))
                : Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: kHeaderBackground,
                          borderRadius: const BorderRadius.only(
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
                                  icon: Icon(Icons.arrow_back_ios_new, color: kPrimaryText),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Search Courses",
                                  style: GoogleFonts.poppins(
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
                              onChanged: (value) => setState(() => searchQuery = value),
                              style: GoogleFonts.poppins(color: kPrimaryText),
                              decoration: InputDecoration(
                                hintText: "Search by course name...",
                                hintStyle: GoogleFonts.poppins(color: kSecondaryText),
                                filled: true,
                                fillColor: kTextFieldFill,
                                prefixIcon: Icon(Icons.search, color: kSecondaryText),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Category Filters
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: ['All', 'AI Engineer', 'Data Scientist', 'Designer']
                                    .map((category) => Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: ChoiceChip(
                                            label: Text(category, style: GoogleFonts.poppins()),
                                            selected: selectedCategory == category,
                                            selectedColor: kPrimaryButton,
                                            backgroundColor: kHeaderBackground,
                                            labelStyle: GoogleFonts.poppins(
                                              color: selectedCategory == category
                                                  ? kPrimaryText
                                                  : kSecondaryText,
                                            ),
                                            onSelected: (selected) {
                                              if (selected) {
                                                setState(() => selectedCategory = category);
                                              }
                                            },
                                          ),
                                        ))
                                    .toList(),
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
                              title: course.title,
                              duration: course.duration,
                              role: course.role ?? 'Unknown',
                              image: course.image ?? 'assets/images/placeholder.jpg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProgramDetailsPage(program: course),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kHeaderBackground,
        currentIndex: 2,
        selectedItemColor: kBottomNavActive,
        unselectedItemColor: kSecondaryText,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CourseScreen()),
              );
              break;
            case 2:
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MessageScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AccountScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Course'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildCourseItem({
    required String title,
    required String duration,
    required String role,
    required String image,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: kBottomNavActive.withAlpha((0.2 * 255).round()),
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kHeaderBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/placeholder.jpg', width: 60, height: 60),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryText,
                    ),
                  ),
                  Text(
                    'Role: $role',
                    style: GoogleFonts.poppins(color: kSecondaryText, fontSize: 14),
                  ),
                  Text(
                    'Duration: $duration',
                    style: GoogleFonts.poppins(color: kSecondaryText, fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}