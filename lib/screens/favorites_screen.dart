// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:excelerate_inquisit/constants.dart';
import 'package:excelerate_inquisit/user_progress.dart';
import 'package:excelerate_inquisit/screens/program_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = UserProgress.favorites;

    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: kPrimaryText)),
        backgroundColor: kHeaderBackground,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet!\nTap heart on a program to save it.',
                textAlign: TextAlign.center,
                style: TextStyle(color: kSecondaryText, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final program = favorites[index];
                return Card(
                  color: kHeaderBackground,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        program.image ?? 'assets/images/placeholder.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      program.title,
                      style: const TextStyle(color: kPrimaryText),
                    ),
                    subtitle: Text(
                      program.role ?? 'N/A',
                      style: const TextStyle(color: kSecondaryText),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        UserProgress.remove(program);
                        setState(() {});
                      },
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProgramDetailsPage(program: program),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
