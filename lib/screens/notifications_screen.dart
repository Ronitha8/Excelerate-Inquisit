// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:excelerate_inquisit/screens/program_details_page.dart';
import 'package:excelerate_inquisit/screens/favorites_screen.dart';
import 'package:excelerate_inquisit/screens/message_screen.dart';
import 'package:excelerate_inquisit/screens/peer_users_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifs = UserProgress.notifications;

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: kHeaderBackground,
        actions: [
          TextButton(
            onPressed: () {
              UserProgress.clearAll();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('All cleared!')));
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: kExcelerateOrange),
            ),
          ),
        ],
      ),
      body: notifs.isEmpty
          ? const Center(
              child: Text(
                'No notifications yet.',
                style: TextStyle(color: kSecondaryText),
              ),
            )
          : ListView.builder(
              itemCount: notifs.length,
              itemBuilder: (ctx, i) {
                final n = notifs[i];
                return ListTile(
                  leading: Icon(_getIcon(n.type), color: _getColor(n.type)),
                  title: Text(
                    n.message,
                    style: GoogleFonts.poppins(color: kPrimaryText),
                  ),
                  subtitle: Text(
                    '${_formatTime(n.timestamp)} ago',
                    style: TextStyle(color: kSecondaryText),
                  ),
                  trailing: n.read
                      ? null
                      : Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: kExcelerateOrange,
                            shape: BoxShape.circle,
                          ),
                        ),
                  onTap: () {
                    UserProgress.markAsRead(n.id);
                    switch (n.type) {
                      case NotificationType.enroll:
                      case NotificationType.favorite:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProgramDetailsPage(program: n.program!),
                          ),
                        );
                        break;
                      case NotificationType.message:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MessageScreen(),
                          ),
                        );
                        break;
                      case NotificationType.system:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PeerUsersScreen(),
                          ),
                        );
                        break;
                    }
                  },
                );
              },
            ),
    );
  }

  IconData _getIcon(NotificationType t) => switch (t) {
    NotificationType.enroll => Icons.school,
    NotificationType.favorite => Icons.favorite,
    NotificationType.message => Icons.message,
    _ => Icons.info,
  };

  Color _getColor(NotificationType t) => switch (t) {
    NotificationType.enroll => Colors.green,
    NotificationType.favorite => Colors.red,
    NotificationType.message => kExcelerateViolet,
    _ => kSecondaryText,
  };

  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes} min';
    if (diff.inDays < 1) return '${diff.inHours} h';
    return '${diff.inDays} d';
  }
}
