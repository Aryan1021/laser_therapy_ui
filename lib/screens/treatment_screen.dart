import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TreatmentScreen extends StatefulWidget {
  final int intensity;
  final int frequency;
  final int duration;

  const TreatmentScreen({
    super.key,
    required this.intensity,
    required this.frequency,
    required this.duration,
  });

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration * 60;
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else if (_remainingSeconds == 0) {
        _stopTimer();
        _showCompletionDialog();
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session Complete', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('The treatment session has completed successfully.', style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.blue)),
          )
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          'Treatment Session',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Time Remaining: ${_formatTime(_remainingSeconds)}',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Intensity', widget.intensity.toString()),
                _buildStat('Frequency', '${widget.frequency} Hz'),
                _buildStat('Duration', '${widget.duration} min'),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _startTimer,
                  child: _buildControlButton(Icons.play_arrow, 'Start'),
                ),
                GestureDetector(
                  onTap: _pauseTimer,
                  child: _buildControlButton(Icons.pause, 'Pause'),
                ),
                GestureDetector(
                  onTap: _stopTimer,
                  child: _buildControlButton(Icons.stop, 'Stop'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _buildControlButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFF0057B7),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.poppins(fontSize: 16))
      ],
    );
  }
}