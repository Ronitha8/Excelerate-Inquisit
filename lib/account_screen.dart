import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'course_screen.dart';
import 'search_screen.dart';
import 'message_screen.dart';
import 'login_screen.dart'; 
import 'main.dart';

class AccountScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: const Text(
          'Account',
          style: TextStyle(
            color: kPrimaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage('assets/images/profile_placeholder.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.displayName ?? 'User Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user?.email ?? 'user@example.com',
                    style: const TextStyle(color: kSecondaryText, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(color: kProgressRemaining),

            // Menu Options
            Expanded(
              child: ListView(
                children: [
                  _buildOption(
                    icon: Icons.favorite_border,
                    title: 'Favourite',
                    onTap: () {},
                  ),
                  _buildOption(
                    icon: Icons.edit_outlined,
                    title: 'Edit Account',
                    onTap: () {},
                  ),
                  _buildOption(
                    icon: Icons.settings_outlined,
                    title: 'Settings and Privacy',
                    onTap: () {},
                  ),
                  _buildOption(
                    icon: Icons.help_outline,
                    title: 'Help',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _buildOption(
                    icon: Icons.logout,
                    title: 'Log Out',
                    color: Colors.redAccent,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();

                      // Navigate directly to LoginScreen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kHeaderBackground,
        currentIndex: 4,
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
                MaterialPageRoute(builder: (_) => CourseScreen()),
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
              // Already here
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

  Widget _buildOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = kPrimaryText,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: kSecondaryText,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
