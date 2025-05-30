import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laser_therapy_ui/screens/setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003B8E),
        elevation: 4,
        title: Text(
          'Laser Settings',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0ECFF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0057B7),
                  foregroundColor: Colors.white,
                  elevation: 6,
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.medical_services, size: 28),
                label: Text(
                  'Laser Therapy',
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD6D6D6), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                ),
                onPressed: null,
                child: Text(
                  'Coming Soon',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: const Color(0xFF888888),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
