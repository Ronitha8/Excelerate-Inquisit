// lib/screens/my_courses_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/models/program_model.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enrolled = UserProgress.enrolled;

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: const Text('My Courses', style: TextStyle(color: kPrimaryText)),
        backgroundColor: kHeaderBackground,
      ),
      body: enrolled.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.school_outlined, size: 80, color: kSecondaryText),
                  const SizedBox(height: 16),
                  Text(
                    'No courses started yet!',
                    style: TextStyle(color: kSecondaryText, fontSize: 18),
                  ),
                  Text(
                    'Go to Course → Start Experience',
                    style: TextStyle(color: kSecondaryText),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: enrolled.length,
              itemBuilder: (context, index) {
                final program = enrolled[index];
                return _buildCourseCard(context, program);
              },
            ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Program program) {
    return Card(
      color: kHeaderBackground,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    program.image ?? 'assets/images/placeholder.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryText,
                        ),
                      ),
                      Text(
                        program.role ?? 'N/A',
                        style: TextStyle(color: kPurple),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    UserProgress.isFavorited(program)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: UserProgress.isFavorited(program)
                        ? Colors.red
                        : kSecondaryText,
                  ),
                  onPressed: () {
                    if (UserProgress.isFavorited(program)) {
                      UserProgress.remove(program);
                    } else {
                      UserProgress.add(program);
                    }
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'Weekly Schedule',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: kPrimaryText,
              ),
            ),
            const SizedBox(height: 8),
            _buildSchedule(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildChip('Live', Colors.green),
                _buildChip('4 Modules', kSecondaryText),
                _buildChip('2h/week', kSecondaryText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedule() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    return Column(
      children: days
          .map(
            (day) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(day, style: TextStyle(color: kSecondaryText)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      color: kPrimaryButton.withValues(alpha: 0.3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '10:00 AM',
                    style: TextStyle(
                      color: kPrimaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      backgroundColor: color.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
