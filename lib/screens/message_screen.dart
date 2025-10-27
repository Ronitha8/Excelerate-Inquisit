import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, String>> messages = [
    {'sender': 'Instructor John', 'message': 'Hey Sara, great progress!', 'time': '2:45 PM'},
    {'sender': 'UI/UX Mentor', 'message': 'Your last design looked amazing!', 'time': '11:30 AM'},
    {'sender': 'System', 'message': 'Reminder: Meeting at 4 PM today.', 'time': '9:10 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: Text("Messages", style: TextStyle(color: kPrimaryText)),
        backgroundColor: kHeaderBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kHeaderBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg['sender']!,
                        style: TextStyle(
                          color: kPrimaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg['message']!,
                        style: TextStyle(
                          color: kSecondaryText,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  msg['time']!,
                  style: TextStyle(color: kSecondaryText, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}