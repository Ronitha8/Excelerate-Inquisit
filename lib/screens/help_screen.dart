import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _questionController = TextEditingController();
  String _answer = '';

  // Simple keyword-based "AI" for demo
  void _answerQuestion(String question) {
    question = question.toLowerCase();
    if (question.contains('login') || question.contains('sign in')) {
      setState(() {
        _answer = 'To log in, use a valid email (e.g., test@example.com) and a password with at least 6 characters. Check Firebase settings if you encounter errors.';
      });
    } else if (question.contains('course') || question.contains('program')) {
      setState(() {
        _answer = 'Courses are listed on the Course screen, accessible from the Home screen. Tap a course to view details. Data is loaded from assets/courses.json.';
      });
    } else if (question.contains('navigate') || question.contains('navigation')) {
      setState(() {
        _answer = 'Use the bottom navigation bar to switch between Home, Courses, and Account. You must log in to access the Home screen.';
      });
    } else {
      setState(() {
        _answer = 'Sorry, I didn’t understand your question. Try asking about login, courses, or navigation!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kHeaderBackground,
        title: Text(
          'Help & Support',
          style: TextStyle(color: kPrimaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ask a Question',
              style: TextStyle(color: kPrimaryText, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: kTextFieldFill,
                hintText: 'e.g., How do I log in?',
                hintStyle: TextStyle(color: kSecondaryText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: kPrimaryText),
              onSubmitted: _answerQuestion,
            ),
            const SizedBox(height: 20),
            Text(
              'Answer:',
              style: TextStyle(color: kPrimaryText, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _answer.isEmpty ? 'Type a question above to get help.' : _answer,
              style: TextStyle(color: kSecondaryText, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}