import 'package:flutter/material.dart';
import 'main.dart';
import 'models/programModel.dart';
// --- 3. PROGRAM DETAILS SCREEN WIDGET ---

class ProgramDetailsPage extends StatelessWidget {
  final Program program;

  const ProgramDetailsPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: const Text(
          'Program Details',
          style: TextStyle(color: kPrimaryText),
        ),
        backgroundColor: kDarkBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 100,
        ), // Space for floating button
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- MAIN HEADER SECTION ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      color: kPrimaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ), //
                  const SizedBox(height: 4),
                  Text(
                    program.role,
                    style: const TextStyle(color: kPurple, fontSize: 16),
                  ), //
                  const SizedBox(height: 16),
                  Text(
                    program.description,
                    style: const TextStyle(color: kSecondaryText, fontSize: 14),
                  ), //
                  const SizedBox(height: 24),

                  // --- KEY METRICS ROW (Duration, Scholarship, Fee, Location) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetric(
                        Icons.access_time,
                        'Duration',
                        program.duration,
                      ),
                      _buildMetric(
                        Icons.monetization_on_outlined,
                        'Scholarship',
                        program.scholarship,
                      ),
                      _buildMetric(Icons.attach_money, 'Fee', program.fee),
                      _buildMetric(
                        Icons.location_on_outlined,
                        'Location',
                        program.location,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- PROJECT DATES CARD ---
            _buildInfoCard(
              title: 'Project Dates',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateColumn(
                      'LAST DATE TO APPLY',
                      program.lastDateToApply,
                    ), //
                    _buildDateColumn('START DATE', program.startdate), //
                    _buildDateColumn('END DATE', program.enddate), //
                  ],
                ),
              ),
            ),

            // --- ELIGIBILITY CARD ---
            _buildInfoCard(
              title: 'Eligibility',
              child: ListTile(
                leading: const Icon(Icons.check_box, color: Colors.green),
                title: Text(
                  program.eligibility,
                  style: const TextStyle(color: kPrimaryText),
                ), //
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // --- REWARDS CARD (Simplified for mobile) ---
            _buildInfoCard(
              title: 'Rewards',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRewardIcon(Icons.military_tech, 'Badge'), //
                  _buildRewardIcon(Icons.workspace_premium, 'Certificate'), //
                  _buildRewardIcon(Icons.school, 'Scholarship'), //
                ],
              ),
            ),

            // --- SKILLS CARD ---
            _buildInfoCard(
              title: 'Skills Gained',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: program.skills
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill,
                          style: const TextStyle(color: kPrimaryText),
                        ),
                        backgroundColor:
                            kHeaderBackground, // Using a darker chip color
                        avatar: const Icon(
                          Icons.lightbulb_outline,
                          color: kSecondaryText,
                          size: 16,
                        ),
                      ),
                    )
                    .toList(), //
              ),
            ),
          ],
        ),
      ),
      // --- FLOATING ACTION BUTTON (START MY EXPERIENCE) ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Action: START MY EXPERIENCE
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kOrange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'START MY EXPERIENCE',
              style: TextStyle(
                color: kPrimaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildMetric(IconData icon, String label, String value) {
    // Center the content within the column
    return Column(
      children: [
        // 1. Icon
        Icon(icon, color: kPurple, size: 28),
        const SizedBox(height: 8), // Increased spacing between icon and text
        Text(
          value,
          style: const TextStyle(
            color: kPrimaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: kSecondaryText,
            fontSize: 10, // Small, secondary text
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDateColumn(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kSecondaryText,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: kPurple, size: 30),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: kSecondaryText, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kPrimaryText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: kHeaderBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
