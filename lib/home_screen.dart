import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'course_screen.dart'; // ADDED: Import for CourseScreen navigation
import 'message_screen.dart'; // ADDED: Import for MessageScreen navigation
import 'search_screen.dart'; // ADDED: Import for SearchScreen navigation
import 'account_screen.dart'; // ADDED: Import for AccountScreen navigation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            TopHeaderSection(),
            LearningProgressCard(),
            HorizontalLearningCards(),
            LearningPlanSection(),
            MeetupBanner(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

// 1. TOP HEADER SECTION
class TopHeaderSection extends StatelessWidget {
  const TopHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/Excelerate_logo.png',
                width: 200,
                fit: BoxFit.contain,
              ),
              // Avatar navigates to Account Screen
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black, size: 26),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Let's start learning",
            style: TextStyle(
              fontSize: 16,
              color: kSecondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// 2. LEARNING PROGRESS CARD
class LearningProgressCard extends StatelessWidget {
  const LearningProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    const int currentProgress = 46;
    const int totalGoal = 60;
    final double progressFraction = currentProgress / totalGoal;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kHeaderBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Learned today',
                  style: TextStyle(
                    fontSize: 14,
                    color: kSecondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'My courses',
                    style: TextStyle(
                      fontSize: 12,
                      color: kSecondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '$currentProgress min',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kPrimaryText,
              ),
            ),
            Text(
              '/ $totalGoal min',
              style: const TextStyle(
                fontSize: 14,
                color: kSecondaryText,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: kProgressRemaining,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progressFraction,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: kPurple,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 3. HORIZONTAL LEARNING CARDS
class HorizontalLearningCards extends StatelessWidget {
  const HorizontalLearningCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Text(
            'What do you want to learn today?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryText,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildLearningCard(
                title: 'Start your UI/UX journey',
                buttonText: 'Get Started',
                backgroundColor: kLightBlueCard,
                illustration: const Icon(
                  Icons.palette_outlined,
                  size: 100,
                  color: Color(0xFF4C5AFE),
                ),
              ),
              const SizedBox(width: 15),
              _buildLearningCard(
                title: 'Review your progress',
                buttonText: 'Check Report',
                backgroundColor: const Color(0xFFFDEBEE),
                illustration: const Icon(
                  Icons.stacked_line_chart,
                  size: 100,
                  color: Color(0xFFC259D4),
                ),
              ),
              const SizedBox(width: 15),
              _buildLearningCard(
                title: 'New: Mastering Figma',
                buttonText: 'Enroll Now',
                backgroundColor: const Color(0xFFFFECCC),
                illustration: const Icon(
                  Icons.design_services_outlined,
                  size: 100,
                  color: Color(0xFFFF8C4B),
                ),
              ),
              const SizedBox(width: 15),
              _buildLearningCard(
                title: 'Become a great coder',
                buttonText: 'View Path',
                backgroundColor: const Color(0xFFDDFDDC),
                illustration: const Icon(
                  Icons.code,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLearningCard({
    required String title,
    required String buttonText,
    required Color backgroundColor,
    required Widget illustration,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: -20, bottom: -20, child: illustration),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOrange,
                  foregroundColor: kPrimaryText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 4. LEARNING PLAN SECTION
class LearningPlanSection extends StatelessWidget {
  const LearningPlanSection({super.key});

  final List<Map<String, String>> planItems = const [
    {'title': 'Packaging Design', 'progress': '40/48'},
    {'title': 'Product Design', 'progress': '6/24'},
    {'title': 'UX Research Principles', 'progress': '12/12'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Plan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryText,
            ),
          ),
          const SizedBox(height: 15),
          ...planItems.map((item) {
            return _buildPlanItem(
              title: item['title']!,
              progress: item['progress']!,
              isCompleted: item['title'] == 'UX Research Principles',
            );
          }),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'more',
                style: TextStyle(color: kPurple, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem({
    required String title,
    required String progress,
    required bool isCompleted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : kSecondaryText,
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryText,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: kSecondaryText,
              ),
            ),
          ),
          Text(
            progress,
            style: const TextStyle(
              fontSize: 16,
              color: kSecondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// 5. MEETUP BANNER
class MeetupBanner extends StatelessWidget {
  const MeetupBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8F5AE6), Color(0xFFC259D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Meetup',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: kPrimaryText,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 180,
                child: Text(
                  'Off-line exchange of learning experiences',
                  style: TextStyle(fontSize: 14, color: kPrimaryText),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFFEE2E2),
                radius: 15,
                child: Icon(Icons.person, size: 18, color: Color(0xFFEF4444)),
              ),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFFFEDD5),
                  radius: 15,
                  child: Icon(Icons.person, size: 18, color: Color(0xFFF97316)),
                ),
              ),
              Transform.translate(
                offset: const Offset(-16, 0),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFDBEAFE),
                  radius: 15,
                  child: Icon(Icons.person, size: 18, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 6. CUSTOM BOTTOM NAVIGATION BAR
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kHeaderBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const NavBarItem(icon: Icons.home, label: 'Home', isActive: true),
          NavBarItem(
            icon: Icons.menu_book,
            label: 'Course',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseScreen()),
              );
            },
          ),
          NavBarItem(
            icon: Icons.search,
            label: 'Search',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
          NavBarItem(
            icon: Icons.message,
            label: 'Message',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen()));
            },
          ),
          NavBarItem(
            icon: Icons.person,
            label: 'Account',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountScreen()));
            },
          ),
        ],
      ),
    );
  }
}

// NavBar Item Widget
class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? kBottomNavActive : kSecondaryText;

    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
