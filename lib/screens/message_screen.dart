// lib/screens/message_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:excelerate_inquisit/screens/chat_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final chats = UserProgress.chats;

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: Text(
          "Messages",
          style: GoogleFonts.poppins(
            color: kPrimaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: chats.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kHeaderBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kExcelerateViolet.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 60,
                      color: kExcelerateViolet,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No messages yet',
                    style: GoogleFonts.poppins(
                      color: kPrimaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Connect with peers!',
                    style: TextStyle(color: kSecondaryText),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final contact = chats[index];
                final lastMsg = contact.messages.isNotEmpty
                    ? contact.messages.last
                    : null;
                return Card(
                  color: kHeaderBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: kExcelerateLavender.withValues(
                        alpha: 0.2,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(contact.avatar),
                      ),
                    ),
                    title: Text(
                      contact.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryText,
                      ),
                    ),
                    subtitle: Text(
                      lastMsg?.text ?? 'Start chatting!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: contact.unreadCount > 0
                            ? kExcelerateOrange
                            : kSecondaryText,
                        fontWeight: contact.unreadCount > 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (contact.unreadCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: kExcelerateOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${contact.unreadCount}',
                              style: TextStyle(
                                color: kPrimaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        Text(
                          _formatTime(contact.lastMessageTime),
                          style: TextStyle(color: kSecondaryText, fontSize: 11),
                        ),
                      ],
                    ),
                    onTap: () {
                      contact.unreadCount = 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(contact: contact),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              },
            ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
