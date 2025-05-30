import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafeModeScreen extends StatefulWidget {
  const SafeModeScreen({super.key});

  @override
  State<SafeModeScreen> createState() => _SafeModeScreenState();
}

class _SafeModeScreenState extends State<SafeModeScreen> {
  bool isLoading = false;

  void _retryConnection() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Simulate success/failure randomly
    bool success = DateTime.now().second % 2 == 0;

    if (success) {
      _showDialog('Success', 'Device connection re-established.', true, goBack: true);
    } else {
      _showDialog('Failure', 'Could not reconnect. Please try again.', false);
    }
  }

  void _showDialog(String title, String message, bool success, {bool goBack = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: success ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              if (goBack) {
                Navigator.of(context).pop(); // Pop SafeModeScreen
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
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
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Please check microcontroller connection or power status.',
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _retryConnection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0057B7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Retry Connection',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}