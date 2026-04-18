import 'dart:async';
import 'package:flutter/material.dart';

/// Pantalla de cronómetro usando Timer.
/// Permite iniciar, pausar, reanudar y reiniciar el conteo de tiempo.
class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;

  /// Inicia el cronómetro.
  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      _isRunning = true;
      _isPaused = false;
    }
  }

  /// Pausa el cronómetro.
  void _pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _isPaused = true;
    }
  }

  /// Reanuda el cronómetro.
  void _resumeTimer() {
    if (_isPaused) {
      _startTimer();
    }
  }

  /// Reinicia el cronómetro.
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
      _isPaused = false;
    });
  }

  /// Formatea el tiempo en HH:MM:SS.
  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro con Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: const Text('Iniciar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: !_isRunning || _isPaused ? null : _pauseTimer,
                  child: const Text('Pausar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: !_isPaused ? null : _resumeTimer,
                  child: const Text('Reanudar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
