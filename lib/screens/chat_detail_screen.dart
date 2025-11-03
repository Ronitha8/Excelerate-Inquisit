// lib/screens/chat_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatContact contact;
  const ChatDetailScreen({super.key, required this.contact});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    UserProgress.sendMessage(widget.contact.userId, _controller.text.trim());
    _controller.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.contact.messages;

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.contact.avatar),
            ),
            SizedBox(width: 12),
            Text(
              widget.contact.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: kPrimaryText,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      'Start the conversation!',
                      style: TextStyle(color: kSecondaryText),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (ctx, i) {
                      final msg = messages[i];
                      return Align(
                        alignment: msg.isSent
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: msg.isSent
                                ? kExcelerateOrange
                                : kHeaderBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: msg.isSent
                                ? null
                                : Border.all(
                                    color: kExcelerateLavender.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(color: kPrimaryText),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: kHeaderBackground,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: kPrimaryText),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: kSecondaryText.withValues(alpha: 0.6),
                      ),
                      filled: true,
                      fillColor: kDarkBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: kExcelerateOrange,
                  child: IconButton(
                    icon: Icon(Icons.send, color: kPrimaryText),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
