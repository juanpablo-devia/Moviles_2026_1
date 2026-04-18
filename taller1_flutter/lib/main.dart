import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String titulo = "Hola, Flutter";

  void cambiarTitulo() {
    setState(() {
      if (titulo == "Hola, Flutter") {
        titulo = "¡Título cambiado!";
      } else {
        titulo = "Hola, Flutter";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Título actualizado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // 🔹 NOMBRE
                const Text(
                  "Juan Pablo Devia",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 IMÁGENES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
                      width: 100,
                      height: 100,
                    ),
                    Image.asset(
                      'assets/images/rana.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 BOTÓN
                ElevatedButton.icon(
                  onPressed: cambiarTitulo,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Cambiar título"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 LISTVIEW
                const Text(
                  "Opciones",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 150,
                  child: ListView(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Perfil"),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Configuración"),
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text("Favoritos"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 GRIDVIEW
                const Text(
                  "Cuadrícula",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 220,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("1", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("2", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("3", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("4", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}