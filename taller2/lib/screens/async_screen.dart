import 'package:flutter/material.dart';
import '../services/simulated_data_service.dart';

/// Estados posibles de la pantalla async.
enum Status { idle, loading, success, error }

/// Pantalla que demuestra el uso de Future, async y await.
/// Corregida con layout centrado, botón siempre visible en estados finales y estructura de scroll.
class AsyncScreen extends StatefulWidget {
  const AsyncScreen({super.key});

  @override
  State<AsyncScreen> createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen>
    with TickerProviderStateMixin {
  final SimulatedDataService _service = SimulatedDataService();
  Status _status = Status.idle;
  String? _result;
  String? _error;
  late AnimationController _dotsController;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _dotsController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
          )
          ..addListener(() {
            setState(() {
              _dotCount = ((_dotsController.value * 3).floor() + 1) % 4;
            });
          })
          ..repeat();
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  /// Método para ejecutar la consulta de datos.
  Future<void> _fetchData() async {
    setState(() {
      _status = Status.loading;
      _error = null;
      _result = null;
    });

    try {
      final data = await _service.fetchData();
      setState(() {
        _result = data;
        _status = Status.success;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _status = Status.error;
      });
    }
  }

  /// Construye el widget de estado según el status actual.
  Widget _buildStatusWidget() {
    switch (_status) {
      case Status.loading:
        return Column(
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 20),
            Text(
              'Cargando${'.' * _dotCount}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        );
      case Status.success:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: Card(
            color: const Color(0xFF1A1A2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFF00E57A), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF00E57A),
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Éxito',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      case Status.error:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: Card(
            color: const Color(0xFF1A1A2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFFF5252), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_rounded,
                    color: Color(0xFFFF5252),
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return Text(
          'Presiona el botón para iniciar la consulta',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: const Text('Asincronía con Future'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                _buildStatusWidget(),
                const SizedBox(height: 32),
                if (_status != Status.loading)
                  ElevatedButton.icon(
                    onPressed: _fetchData,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Relanzar Consulta'),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
