import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/models/program_model.dart';
import 'package:excelerate_inquisit/screens/home_screen.dart';
import 'package:excelerate_inquisit/screens/course_screen.dart';
import 'package:excelerate_inquisit/screens/search_screen.dart';
import 'package:excelerate_inquisit/screens/message_screen.dart';
import 'package:excelerate_inquisit/screens/account_screen.dart';
import 'package:excelerate_inquisit/favorites.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramDetailsPage extends StatefulWidget {
  final Program program;

  const ProgramDetailsPage({super.key, required this.program});

  @override
  State<ProgramDetailsPage> createState() => _ProgramDetailsPageState();
}

class _ProgramDetailsPageState extends State<ProgramDetailsPage> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    isFavorited = Favorites.isFavorited(widget.program);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorited) {
        Favorites.remove(widget.program);
        isFavorited = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from favorites!')),
        );
      } else {
        Favorites.add(widget.program);
        isFavorited = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to favorites!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: Text(
          widget.program.title,
          style: GoogleFonts.poppins(
            color: kPrimaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryText),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : kSecondaryText,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Image.asset(
                widget.program.image ?? 'assets/images/placeholder.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: kSecondaryText,
                  child: const Icon(Icons.image_not_supported, size: 50, color: kPrimaryText),
                ),
              ),
            ),
            // Main Header Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.program.title,
                    style: GoogleFonts.poppins(
                      color: kPrimaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.program.role ?? 'N/A',
                    style: GoogleFonts.poppins(
                      color: kPurple,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.program.description,
                    style: GoogleFonts.poppins(
                      color: kSecondaryText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Key Metrics Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetric(Icons.access_time, 'Duration', widget.program.duration),
                      _buildMetric(Icons.monetization_on_outlined, 'Scholarship', widget.program.scholarship ?? 'N/A'),
                      _buildMetric(Icons.attach_money, 'Fee', widget.program.fee ?? 'N/A'),
                      _buildMetric(Icons.location_on_outlined, 'Location', widget.program.location ?? 'N/A'),
                    ],
                  ),
                ],
              ),
            ),
            // Project Dates Card
            _buildInfoCard(
              title: 'Project Dates',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateColumn('LAST DATE TO APPLY', widget.program.lastDateToApply ?? 'N/A'),
                    _buildDateColumn('START DATE', widget.program.startdate ?? 'N/A'),
                    _buildDateColumn('END DATE', widget.program.enddate ?? 'N/A'),
                  ],
                ),
              ),
            ),
            // Eligibility Card
            _buildInfoCard(
              title: 'Eligibility',
              child: ListTile(
                leading: const Icon(Icons.check_box, color: Colors.green),
                title: Text(
                  widget.program.eligibility ?? 'N/A',
                  style: GoogleFonts.poppins(color: kPrimaryText),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            // Rewards Card
            _buildInfoCard(
              title: 'Rewards',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRewardIcon(Icons.military_tech, 'Badge'),
                  _buildRewardIcon(Icons.workspace_premium, 'Certificate'),
                  _buildRewardIcon(Icons.school, 'Scholarship'),
                ],
              ),
            ),
            // Skills Card
            _buildInfoCard(
              title: 'Skills Gained',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: (widget.program.skills ?? [])
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill,
                          style: GoogleFonts.poppins(color: kPrimaryText),
                        ),
                        backgroundColor: kHeaderBackground,
                        avatar: Icon(
                          Icons.lightbulb_outline,
                          color: kSecondaryText,
                          size: 16,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Started ${widget.program.title}!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryButton,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'START MY EXPERIENCE',
              style: GoogleFonts.poppins(
                color: kPrimaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kHeaderBackground,
        currentIndex: 1,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
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

  Widget _buildMetric(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: kPurple, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: kPrimaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: kSecondaryText,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDateColumn(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: kSecondaryText,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: GoogleFonts.poppins(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: kPurple, size: 30),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: kSecondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: kPrimaryText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: kHeaderBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}