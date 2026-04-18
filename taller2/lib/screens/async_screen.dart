import 'package:flutter/material.dart';
import '../services/simulated_data_service.dart';

/// Pantalla que demuestra el uso de Future, async y await.
/// Muestra estados de carga, éxito y error, con posibilidad de relanzar la consulta.
class AsyncScreen extends StatefulWidget {
  const AsyncScreen({super.key});

  @override
  State<AsyncScreen> createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen> {
  final SimulatedDataService _service = SimulatedDataService();
  String? _result;
  bool _isLoading = false;
  String? _error;

  /// Método para ejecutar la consulta de datos.
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
    });

    try {
      final data = await _service.fetchData();
      setState(() {
        _result = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asincronía con Future')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Cargando…'),
                ],
              )
            else if (_error != null)
              Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 20),
                  Text('Error: $_error'),
                ],
              )
            else if (_result != null)
              Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 50),
                  const SizedBox(height: 20),
                  Text('Éxito: $_result'),
                ],
              )
            else
              const Text('Presiona el botón para iniciar la consulta'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Relanzar Consulta'),
            ),
          ],
        ),
      ),
    );
  }
}
