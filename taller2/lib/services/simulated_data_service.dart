import 'dart:math';

/// Servicio que simula la consulta de datos usando Future.
/// Puede lanzar un error aleatoriamente para demostrar manejo de excepciones.
class SimulatedDataService {
  /// Simula una consulta de datos que toma 2-3 segundos.
  /// Retorna un mensaje de éxito o lanza una excepción aleatoriamente.
  Future<String> fetchData() async {
    print('Antes de llamar al servicio de datos');
    await Future.delayed(
      Duration(seconds: Random().nextInt(2) + 2),
    ); // 2-3 segundos
    print('Durante la espera en el servicio');

    // Simular error aleatoriamente
    if (Random().nextBool()) {
      throw Exception('Error simulado en la consulta de datos');
    }

    print('Después de recibir el resultado');
    return 'Datos obtenidos exitosamente: ${DateTime.now()}';
  }
}
