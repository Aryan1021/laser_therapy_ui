import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafeModeScreen extends StatelessWidget {
  const SafeModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text(
          "Safe Mode",
          style: GoogleFonts.poppins(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_rounded, size: 80, color: Colors.red[700]),
              const SizedBox(height: 20),
              Text(
                'Device in Safe Mode',
                style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red[700]),
              ),
              const SizedBox(height: 10),
              Text(
                'Please check microcontroller connection or power status.',
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Retry logic or restart
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0057B7),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Retry Connection',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to Settings',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}