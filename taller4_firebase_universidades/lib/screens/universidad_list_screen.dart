import 'package:flutter/material.dart';
import '../models/universidad.dart';
import '../services/universidad_service.dart';
import 'universidad_form_screen.dart';

class UniversidadListScreen extends StatelessWidget {
  const UniversidadListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = UniversidadService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Universidades'),
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: service.getUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final universidades = snapshot.data ?? [];
          if (universidades.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay universidades registradas',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final u = universidades[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    child: Text(u.nombre.isNotEmpty ? u.nombre[0].toUpperCase() : '?'),
                  ),
                  title: Text(
                    u.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NIT: ${u.nit}'),
                      Text(u.direccion),
                      Text(u.telefono),
                      Text(
                        u.paginaWeb,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmarEliminar(context, service, u),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UniversidadFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarEliminar(
      BuildContext context, UniversidadService service, Universidad u) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar universidad'),
        content: Text('¿Deseas eliminar "${u.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              service.eliminarUniversidad(u.id!);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
