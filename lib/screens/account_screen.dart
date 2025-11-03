// lib/screens/account_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/screens/home_screen.dart';
import 'package:excelerate_inquisit/screens/course_screen.dart';
import 'package:excelerate_inquisit/screens/login_screen.dart';
import 'package:excelerate_inquisit/screens/help_screen.dart';
import 'package:excelerate_inquisit/screens/message_screen.dart';
import 'package:excelerate_inquisit/screens/favorites_screen.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user;
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  String _gender = 'male';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? 'User');
    _bioController = TextEditingController(text: 'Aspiring learner');
    _gender = user?.photoURL?.contains('female') == true ? 'female' : 'male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final newName = _nameController.text.trim();
    final newBio = _bioController.text.trim();
    if (newName.isEmpty) return;

    try {
      await user?.updateDisplayName(newName);
      final photoUrl = _gender == 'male'
          ? 'assets/images/male_avatar.png'
          : 'assets/images/female_avatar.png';
      await user?.updatePhotoURL(photoUrl);

      if (!mounted) return;
      setState(() {});
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarPath = _gender == 'male'
        ? 'assets/images/male_avatar.png'
        : 'assets/images/female_avatar.png';

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            color: kPrimaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: kExcelerateViolet,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: AssetImage(avatarPath),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _nameController.text,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryText,
                    ),
                  ),
                  Text(
                    user?.email ?? 'user@excelerate.co.za',
                    style: TextStyle(color: kSecondaryText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Divider(color: kExcelerateLavender.withOpacity(0.3)),
            Expanded(
              child: ListView(
                children: [
                  _buildOption(
                    icon: Icons.favorite,
                    title: 'Favorites (${UserProgress.favorites.length})',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoritesScreen(),
                      ),
                    ),
                  ),
                  _buildOption(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () => _showEditDialog(),
                  ),
                  _buildOption(
                    icon: Icons.help_outline,
                    title: 'Help',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HelpScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildOption(
                    icon: Icons.logout,
                    title: 'Log Out',
                    color: Colors.redAccent,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kHeaderBackground,
        currentIndex: 4,
        selectedItemColor: kExcelerateOrange,
        unselectedItemColor: kSecondaryText,
        showUnselectedLabels: true,
        onTap: (index) {
          final screens = [
            const HomeScreen(),
            const CourseScreen(),
            null,
            const MessageScreen(),
            null,
          ];
          if (screens[index] != null && index != 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => screens[index]!),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Course',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: kHeaderBackground,
          title: Text('Edit Profile', style: TextStyle(color: kPrimaryText)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: kSecondaryText),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kExcelerateLavender),
                  ),
                ),
                style: TextStyle(color: kPrimaryText),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: kSecondaryText),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kExcelerateLavender),
                  ),
                ),
                style: TextStyle(color: kPrimaryText),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setStateDialog(() => _gender = val);
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(color: kSecondaryText),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kExcelerateLavender),
                  ),
                ),
                dropdownColor: kHeaderBackground,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: TextStyle(color: kSecondaryText)),
            ),
            ElevatedButton(
              onPressed: () {
                _updateProfile();
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kExcelerateOrange,
              ),
              child: Text('Save', style: TextStyle(color: kPrimaryText)),
            ),
          ],
        ),
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
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: kSecondaryText, size: 16),
      onTap: onTap,
    );
  }
}
