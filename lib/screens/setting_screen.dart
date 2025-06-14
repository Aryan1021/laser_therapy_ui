import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'treatment_screen.dart';
import 'safe_mode_screen.dart';
import '../services/uart_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _intensity = 5;
  int _frequency = 10;
  String _duration = '15';

  UARTService? _uartService;
  bool _connected = false;

  void _sendTreatmentCommand(BuildContext context) async {
    _uartService = UARTService();
    print('>> Trying to connect UART...');
    final success = await _uartService!.connect();
    print('>> UART connected: $success');

    setState(() => _connected = success);

    if (success) {
      try {
        print('>> Sending UART command...');
        _uartService!.send("INT:${_intensity.toInt()};FREQ:$_frequency;DUR:$_duration;");

        print('>> Listening for UART data...');
        final List<String> received = [];
        final sub = _uartService!.onData.listen((data) {
          received.add(data);
          print('>> Received: $data');
        });

        await Future.delayed(const Duration(seconds: 2));
        await sub.cancel();

        if (!mounted) return;
        print('>> Navigating to TreatmentScreen...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreatmentScreen(
              intensity: _intensity.toInt(),
              frequency: _frequency,
              duration: int.tryParse(_duration) ?? 0,
              receivedMessages: received,
            ),
          ),
        );
        print('>> Navigation complete');
      } catch (e) {
        print('Navigation error: $e');
      }
    } else {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SafeModeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003B8E),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Configure Treatment',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SafeModeScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Intensity'),
            Slider(
              value: _intensity,
              min: 1,
              max: 10,
              divisions: 9,
              label: _intensity.toString(),
              onChanged: (value) => setState(() => _intensity = value),
            ),
            const SizedBox(height: 20),
            _buildLabel('Frequency (Hz)'),
            DropdownButtonFormField<int>(
              value: _frequency,
              items: [10, 20, 30, 40]
                  .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                  .toList(),
              onChanged: (value) => setState(() => _frequency = value ?? 10),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            _buildLabel('Duration (min)'),
            TextFormField(
              initialValue: _duration,
              keyboardType: TextInputType.number,
              onChanged: (value) => _duration = value,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0057B7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => _sendTreatmentCommand(context),
                child: Text(
                  'Proceed to Treatment',
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
