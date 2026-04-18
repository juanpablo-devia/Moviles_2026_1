import 'package:flutter/material.dart';
import 'async_screen.dart';
import 'timer_screen.dart';
import 'isolate_screen.dart';

/// Pantalla principal con navegación a las diferentes funcionalidades.
/// Rediseñada con tema oscuro profesional, círculos decorativos, header con gradiente y cards coloridas.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(title: const Text('Taller Flutter')),
      body: Stack(
        children: [
          // Círculos decorativos
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: -80,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4081).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Header con gradiente
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF7C4DFF), Color(0xFF00E5FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Taller Flutter',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Cards de navegación
                _buildNavCard(
                  context,
                  'Future / Async',
                  'Consulta asíncrona con manejo de estados',
                  Icons.cloud_download_rounded,
                  const Color(0xFF00E5FF),
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AsyncScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildNavCard(
                  context,
                  'Cronómetro',
                  'Timer con estados de control',
                  Icons.timer_rounded,
                  const Color(0xFF7C4DFF),
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimerScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildNavCard(
                  context,
                  'Isolate',
                  'Tarea CPU-bound en segundo plano',
                  Icons.developer_board_rounded,
                  const Color(0xFFFF4081),
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IsolateScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color accentColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF1A1A2E),
          border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: accentColor),
            ],
          ),
        ),
      ),
    );
  }
}
