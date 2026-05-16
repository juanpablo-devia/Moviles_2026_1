import 'package:flutter/material.dart';
import '../models/universidad.dart';
import '../services/universidad_service.dart';

class UniversidadFormScreen extends StatefulWidget {
  const UniversidadFormScreen({super.key});

  @override
  State<UniversidadFormScreen> createState() => _UniversidadFormScreenState();
}

class _UniversidadFormScreenState extends State<UniversidadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nitCtrl = TextEditingController();
  final _nombreCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _paginaWebCtrl = TextEditingController();
  bool _guardando = false;

  @override
  void dispose() {
    _nitCtrl.dispose();
    _nombreCtrl.dispose();
    _direccionCtrl.dispose();
    _telefonoCtrl.dispose();
    _paginaWebCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    try {
      await UniversidadService().crearUniversidad(
        Universidad(
          nit: _nitCtrl.text.trim(),
          nombre: _nombreCtrl.text.trim(),
          direccion: _direccionCtrl.text.trim(),
          telefono: _telefonoCtrl.text.trim(),
          paginaWeb: _paginaWebCtrl.text.trim(),
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Universidad guardada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Nueva Universidad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campo(_nitCtrl, 'NIT', Icons.badge),
              const SizedBox(height: 12),
              _campo(_nombreCtrl, 'Nombre', Icons.school),
              const SizedBox(height: 12),
              _campo(_direccionCtrl, 'Dirección', Icons.location_on),
              const SizedBox(height: 12),
              _campo(_telefonoCtrl, 'Teléfono', Icons.phone,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              TextFormField(
                controller: _paginaWebCtrl,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Página Web',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                  final uri = Uri.tryParse(v.trim());
                  if (uri == null ||
                      (!uri.scheme.startsWith('http') &&
                          !uri.scheme.startsWith('https'))) {
                    return 'Ingresa una URL válida (http:// o https://)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _guardando ? null : _guardar,
                  child: _guardando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Guardar Universidad'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
    );
  }
}
