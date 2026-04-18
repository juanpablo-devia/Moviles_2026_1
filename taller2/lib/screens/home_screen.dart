import 'package:flutter/material.dart';
import 'async_screen.dart';
import 'timer_screen.dart';
import 'isolate_screen.dart';

/// Pantalla principal con navegación a las diferentes funcionalidades.
/// Presenta tres cards/botones para acceder a cada taller.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taller de Procesamiento en Segundo Plano'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationCard(
              context,
              'Asincronía con Future',
              'Demuestra el uso de Future, async y await',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AsyncScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _buildNavigationCard(
              context,
              'Cronómetro con Timer',
              'Implementa un cronómetro usando Timer',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimerScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _buildNavigationCard(
              context,
              'Isolate para Tarea Pesada',
              'Ejecuta tareas CPU-bound en un isolate',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IsolateScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
