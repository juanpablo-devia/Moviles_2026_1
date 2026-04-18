import 'dart:async';
import 'package:flutter/material.dart';

/// Enum para los estados del cronómetro.
enum TimerState { idle, running, paused }

/// Pantalla de cronómetro rediseñada con estilo moderno y colorido.
/// Incluye lógica corregida para el botón Reanudar y visibilidad condicional de botones.
class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  TimerState _state = TimerState.idle;
  Timer? _timer;
  int _elapsedSeconds = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  /// Inicia el cronómetro (solo desde idle).
  void _start() {
    if (_state == TimerState.idle) {
      _state = TimerState.running;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _elapsedSeconds++);
      });
    }
  }

  /// Pausa el cronómetro (solo desde running).
  void _pause() {
    if (_state == TimerState.running) {
      _timer?.cancel();
      _timer = null;
      _state = TimerState.paused;
      setState(() {});
    }
  }

  /// Reanuda el cronómetro (solo desde paused, sin resetear tiempo).
  void _resume() {
    if (_state == TimerState.paused) {
      _state = TimerState.running;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _elapsedSeconds++);
      });
    }
  }

  /// Reinicia el cronómetro (desde running o paused).
  void _reset() {
    _timer?.cancel();
    _timer = null;
    _elapsedSeconds = 0;
    _state = TimerState.idle;
    setState(() {});
  }

  /// Formatea el tiempo en HH:MM:SS.
  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  /// Construye el display del tiempo con estilo circular.
  Widget _buildTimeDisplay() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF0F3460), Color(0xFF16213E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE94560).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Barra de progreso circular animada
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: (_elapsedSeconds % 60) / 60.0, // Ciclo cada 60 segundos
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFFE94560),
              ),
              backgroundColor: Colors.white24,
            ),
          ),
          // Texto del tiempo
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _formatTime(_elapsedSeconds),
                  key: ValueKey<String>(_formatTime(_elapsedSeconds)),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    shadows: [Shadow(color: Color(0xFFE94560), blurRadius: 10)],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'CRONÓMETRO',
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 6,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construye un botón estilizado.
  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(130, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: color.withOpacity(0.5),
      ),
    );
  }

  /// Construye la fila de botones según el estado.
  Widget _buildButtons() {
    switch (_state) {
      case TimerState.idle:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              text: 'Iniciar',
              icon: Icons.play_arrow,
              color: const Color(0xFF4CAF50),
              onPressed: _start,
            ),
          ],
        );
      case TimerState.running:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              text: 'Pausar',
              icon: Icons.pause,
              color: const Color(0xFFFFC107),
              onPressed: _pause,
            ),
            const SizedBox(width: 16),
            _buildButton(
              text: 'Reiniciar',
              icon: Icons.refresh,
              color: const Color(0xFFE94560),
              onPressed: _reset,
            ),
          ],
        );
      case TimerState.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              text: 'Reanudar',
              icon: Icons.play_circle_filled,
              color: const Color(0xFF2196F3),
              onPressed: _resume,
            ),
            const SizedBox(width: 16),
            _buildButton(
              text: 'Reiniciar',
              icon: Icons.refresh,
              color: const Color(0xFFE94560),
              onPressed: _reset,
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: const Text('Cronómetro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          _buildTimeDisplay(),
          const SizedBox(height: 60),
          _buildButtons(),
          const Spacer(),
        ],
      ),
    );
  }
}
