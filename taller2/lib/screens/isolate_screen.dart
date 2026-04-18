import 'dart:isolate';
import 'package:flutter/material.dart';

/// Pantalla que demuestra el uso de Isolate para tareas pesadas.
/// Ejecuta una suma de números grandes en un isolate separado.
class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  bool _isProcessing = false;
  int? _result;
  String? _error;

  /// Función que se ejecuta en el isolate: suma de 1 a n.
  static void _sumInIsolate(SendPort sendPort) {
    print('Mensaje desde el isolate: iniciando tarea pesada');
    const int n = 100000000; // 10^8
    int sum = 0;
    for (int i = 1; i <= n; i++) {
      sum += i;
    }
    print('Mensaje desde el isolate: tarea completada');
    sendPort.send(sum);
  }

  /// Ejecuta la tarea en un isolate.
  Future<void> _runIsolate() async {
    setState(() {
      _isProcessing = true;
      _error = null;
      _result = null;
    });

    final receivePort = ReceivePort();
    try {
      await Isolate.spawn(_sumInIsolate, receivePort.sendPort);
      print('Mensaje desde el hilo principal: isolate creado');

      final result = await receivePort.first as int;
      setState(() {
        _result = result;
      });
      print('Mensaje desde el hilo principal: resultado recibido');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      receivePort.close();
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate para Tarea Pesada')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isProcessing)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Procesando…'),
                ],
              )
            else if (_error != null)
              Text('Error: $_error')
            else if (_result != null)
              Text('Resultado: $_result')
            else
              const Text('Presiona el botón para ejecutar la tarea'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _runIsolate,
              child: const Text('Ejecutar Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
