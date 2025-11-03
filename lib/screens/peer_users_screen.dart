// lib/screens/peer_users_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:excelerate_inquisit/screens/chat_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PeerUsersScreen extends StatelessWidget {
  const PeerUsersScreen({super.key});

  final List<Map<String, String>> peers = const [
    {
      'id': 'alice@learn.co',
      'name': 'Alice Chen',
      'bio': 'UI/UX enthusiast exploring Figma',
      'avatar': 'assets/images/female_avatar.png',
    },
    {
      'id': 'bob@learn.co',
      'name': 'Bob Kim',
      'bio': 'Frontend dev passionate about React',
      'avatar': 'assets/images/male_avatar.png',
    },
    {
      'id': 'sara@learn.co',
      'name': 'Sara Lee',
      'bio': 'Product designer with 2+ years experience',
      'avatar': 'assets/images/female_avatar.png',
    },
    {
      'id': 'mike@learn.co',
      'name': 'Mike Davis',
      'bio': 'Data scientist using Python for insights',
      'avatar': 'assets/images/male_avatar.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: const Text(
          'Peers in Your Courses',
          style: TextStyle(color: kPrimaryText),
        ),
        backgroundColor: kHeaderBackground,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: peers.length,
        itemBuilder: (ctx, i) {
          final p = peers[i];
          return Card(
            color: kHeaderBackground,
            child: ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(p['avatar']!)),
              title: Text(
                p['name']!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryText,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['bio']!, style: TextStyle(color: kSecondaryText)),
                  const SizedBox(height: 4),
                  Text(
                    'Joined 2 days ago',
                    style: TextStyle(color: kSecondaryText, fontSize: 12),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  final contact = ChatContact(
                    userId: p['id']!,
                    name: p['name']!,
                    avatar: p['avatar']!,
                    bio: p['bio']!,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(contact: contact),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kExcelerateViolet,
                ),
                child: const Text(
                  'Chat',
                  style: TextStyle(color: kPrimaryText),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
