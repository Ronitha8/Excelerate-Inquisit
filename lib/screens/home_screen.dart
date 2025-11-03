// lib/screens/home_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/models/program_model.dart';
import 'package:excelerate_inquisit/screens/program_details_page.dart';
import 'package:excelerate_inquisit/screens/my_courses_screen.dart';
import 'package:excelerate_inquisit/screens/favorites_screen.dart';
import 'package:excelerate_inquisit/screens/notifications_screen.dart';
import 'package:excelerate_inquisit/screens/peer_users_screen.dart';
import 'package:excelerate_inquisit/screens/course_screen.dart';
import 'package:excelerate_inquisit/screens/message_screen.dart';
import 'package:excelerate_inquisit/screens/account_screen.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _gender = 'male';
  String? _selectedScreen;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _gender = user?.photoURL?.contains('female') == true ? 'female' : 'male';
  }

  final _screens = {
    'My Courses': const MyCoursesScreen(),
    'Favorites': const FavoritesScreen(),
    'Notifications': const NotificationsScreen(),
    'Account': const AccountScreen(),
  };

  @override
  Widget build(BuildContext context) {
    final avatarPath = _gender == 'male'
        ? 'assets/images/male_avatar.png'
        : 'assets/images/female_avatar.png';

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedScreen,
            hint: Text('Navigate...', style: TextStyle(color: kPrimaryText)),
            items: _screens.keys
                .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => _screens[val]!),
                );
              }
            },
            dropdownColor: kHeaderBackground,
            icon: Icon(Icons.menu, color: kPrimaryText),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                ),
              ),
              if (UserProgress.unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: kExcelerateOrange,
                    child: Text(
                      '${UserProgress.unreadCount}',
                      style: TextStyle(fontSize: 10, color: kPrimaryText),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(avatarPath),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kExceleratePurple, kExcelerateViolet],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/excelerate_logo.png', height: 40),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.poppins(
                          color: kPrimaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Keep learning, keep growing',
                        style: TextStyle(
                          color: kExcelerateLavender,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // MY COURSES
            _buildSectionTitle(
              'My Courses',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyCoursesScreen()),
              ),
            ),
            UserProgress.enrolled.isEmpty
                ? _buildEmptyCard('No courses yet. Start one!', Icons.school)
                : _buildMyCoursesRow(context),
            SizedBox(height: 24),

            // CONTINUE LEARNING
            _buildSectionTitle('Continue Learning', null),
            ...UserProgress.enrolled
                .take(3)
                .map((p) => _buildContinueCard(context, p)),
            SizedBox(height: 24),

            // YOUR PROGRESS
            _buildSectionTitle('Your Progress', null),
            _buildStatsGrid(context),
            SizedBox(height: 24),

            // PEERS
            _buildSectionTitle(
              'Connect with Peers',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PeerUsersScreen()),
              ),
            ),
            _buildPeerPreview(),
            SizedBox(height: 24),

            // RECOMMENDED
            _buildSectionTitle(
              'Recommended for You',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CourseScreen()),
              ),
            ),
            _buildRecommendedRow(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback? onTap) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kExceleratePurple,
        ),
      ),
      if (onTap != null)
        TextButton(
          onPressed: onTap,
          child: Text('See all', style: TextStyle(color: kExcelerateOrange)),
        ),
    ],
  );

  Widget _buildEmptyCard(String text, IconData icon) => Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: kHeaderBackground,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Column(
        children: [
          Icon(icon, size: 50, color: kExcelerateOrange),
          SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: kSecondaryText),
          ),
        ],
      ),
    ),
  );

  Widget _buildMyCoursesRow(BuildContext context) => SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: UserProgress.enrolled.length,
      itemBuilder: (ctx, i) {
        final p = UserProgress.enrolled[i];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProgramDetailsPage(program: p)),
          ),
          child: Container(
            width: 140,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kExceleratePurple, kExcelerateViolet],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    p.image ?? 'assets/images/placeholder.jpg',
                    height: 60,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryText),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _buildContinueCard(BuildContext context, Program p) {
    final minutes = UserProgress.getTimeSpent(p);
    return Card(
      color: kHeaderBackground,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            p.image ?? 'assets/images/placeholder.jpg',
          ),
        ),
        title: Text(
          p.title,
          style: TextStyle(color: kPrimaryText, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$minutes min spent',
          style: TextStyle(color: kSecondaryText),
        ),
        trailing: Text(
          'Continue',
          style: TextStyle(
            color: kExcelerateOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProgramDetailsPage(program: p)),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    childAspectRatio: 3,
    children: [
      _buildStatCard(
        'Courses',
        '${UserProgress.enrolled.length}',
        Icons.menu_book,
        kExcelerateBlue,
      ),
      _buildStatCard(
        'Favorites',
        '${UserProgress.favorites.length}',
        Icons.favorite,
        kExcelerateOrange,
      ),
      _buildStatCard(
        'Time Today',
        '46 min',
        Icons.access_time,
        kExcelerateViolet,
      ),
      _buildStatCard(
        'Alerts',
        '${UserProgress.unreadCount}',
        Icons.notifications,
        kExceleratePurple,
      ),
    ],
  );

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) => Card(
    color: kHeaderBackground,
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryText,
            ),
          ),
          Text(label, style: TextStyle(color: kSecondaryText)),
        ],
      ),
    ),
  );

  Widget _buildPeerPreview() => Card(
    color: kHeaderBackground,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: kExcelerateBlue,
        child: Icon(Icons.people, color: kPrimaryText),
      ),
      title: Text(
        '12 peers in your courses',
        style: TextStyle(color: kPrimaryText),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: kExcelerateOrange),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PeerUsersScreen()),
      ),
    ),
  );

  Widget _buildRecommendedRow(BuildContext context) => SizedBox(
    height: 180,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (ctx, i) => Container(
        width: 140,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kExcelerateViolet, kExceleratePurple],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/images/placeholder.jpg',
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Course $i',
                    style: TextStyle(
                      color: kPrimaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2h • Live',
                    style: TextStyle(color: kExcelerateLavender, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildBottomNav(BuildContext context) => BottomAppBar(
    color: kHeaderBackground,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(Icons.home, 'Home', true),
        _navItem(
          Icons.menu_book,
          'Courses',
          false,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CourseScreen()),
          ),
        ),
        _navItem(
          Icons.message,
          'Messages',
          false,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MessageScreen()),
          ),
        ),
        _navItem(
          Icons.notifications,
          'Alerts',
          false,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        ),
      ],
    ),
  );

  Widget _navItem(
    IconData icon,
    String label,
    bool active, [
    VoidCallback? onTap,
  ]) => InkWell(
    onTap: onTap ?? () {},
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? kExceleratePurple : kSecondaryText),
        Text(
          label,
          style: TextStyle(
            color: active ? kExceleratePurple : kSecondaryText,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
