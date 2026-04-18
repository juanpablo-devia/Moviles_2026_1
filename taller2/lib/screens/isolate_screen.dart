import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Función top-level que ejecuta la tarea pesada: suma de 1 a n.
/// Esta función puede ser usada con compute() para compatibilidad con Web.
int heavyTask(int n) {
  print('Mensaje desde el isolate/tarea: iniciando tarea pesada');
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  print('Mensaje desde el isolate/tarea: tarea completada');
  return sum;
}

/// Pantalla que demuestra el uso de compute() para tareas pesadas.
/// Rediseñada con tema oscuro, card para resultado, progress indicator y textos estilo terminal.
class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  bool _isProcessing = false;
  int? _result;
  String? _error;
  String _mainThreadMessage = '';
  String _isolateMessage = '';
  Stopwatch? _stopwatch;

  /// Ejecuta la tarea pesada usando compute().
  Future<void> _runTask() async {
    setState(() {
      _isProcessing = true;
      _error = null;
      _result = null;
      _mainThreadMessage = '';
      _isolateMessage = '';
    });

    _stopwatch = Stopwatch()..start();
    setState(() {
      _mainThreadMessage = 'Mensaje desde el hilo principal: iniciando compute';
    });

    try {
      final result = await compute(heavyTask, 100000000); // 10^8
      _stopwatch!.stop();
      setState(() {
        _result = result;
        _mainThreadMessage +=
            '\nMensaje desde el hilo principal: resultado recibido';
        _isolateMessage =
            'Mensaje desde el isolate/tarea: iniciando tarea pesada\nMensaje desde el isolate/tarea: tarea completada';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: const Text('Isolate para Tarea Pesada'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card para resultado
            Card(
              color: const Color(0xFF1A1A2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: const Color(0xFFFF4081).withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 120),
                padding: const EdgeInsets.all(20),
                child: _isProcessing
                    ? Column(
                        children: [
                          LinearProgressIndicator(
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFFFF4081),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Ejecutando en segundo plano…',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )
                    : _error != null
                    ? Center(
                        child: Text(
                          'Error: $_error',
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : _result != null
                    ? Column(
                        children: [
                          Text(
                            '$_result',
                            style: const TextStyle(
                              color: Color(0xFFFF4081),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Suma completada en ${_stopwatch?.elapsed.inSeconds ?? 0} segundos',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          'Resultado aparecerá aquí',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Textos estilo terminal
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A14),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF7C4DFF).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hilo Principal:',
                    style: TextStyle(
                      color: Color(0xFF00E57A),
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _mainThreadMessage.isEmpty ? '...' : _mainThreadMessage,
                    style: const TextStyle(
                      color: Color(0xFF00E57A),
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Isolate/Tarea:',
                    style: TextStyle(
                      color: Color(0xFF00E57A),
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _isolateMessage.isEmpty ? '...' : _isolateMessage,
                    style: const TextStyle(
                      color: Color(0xFF00E57A),
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _runTask,
              icon: const Icon(Icons.rocket_launch_rounded),
              label: const Text('Ejecutar Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
