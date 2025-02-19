import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'admin_empresa_screen.dart'; // Asegúrate de importar la pantalla donde deseas regresar.

class CrearEmpresaScreen extends StatelessWidget {
  const CrearEmpresaScreen({super.key});

  // Función para mostrar el cuadro de confirmación
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Column(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.blue, // Color del ícono
                size: 60, // Tamaño del ícono ajustado
              ),
              const SizedBox(height: 20),
              const Text(
                'Se ha guardado los cambios',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22, // Aumento del tamaño del texto
                  color: Color.fromARGB(255, 8, 76, 131), // Texto en azul
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // Botón "Ir a inicio"
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color azul del botón
                  minimumSize: Size(180, 50), // Tamaño adecuado para el botón
                  textStyle: const TextStyle(fontSize: 18), // Ajuste de tamaño de texto
                ),
                onPressed: () {
                  // Regresar a la pantalla de AdminEmpresaScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminEmpresaScreen(),
                    ),
                  );
                },
                child: const Text('Ir a inicio'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Header(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Crear Empresa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3984),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Icono de la cámara con un círculo alrededor
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Color de fondo del círculo
              shape: BoxShape.circle, // Forma circular
              border: Border.all(
                color: Colors.blue, // Color del borde
                width: 2, // Grosor del borde
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 40),
              onPressed: () {
                // Agregar funcionalidad para elegir una foto de empresa
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de la Empresa',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Alineación de los botones "Guardar" y "Cancelar"
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
            children: <Widget>[
              // Botón Cancelar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Botón de "Cancelar" gris
                  minimumSize: Size(120, 40), // Tamaño adecuado para los botones
                ),
                onPressed: () {
                  // Función para cancelar y regresar a la pantalla anterior
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              // Espaciado entre los botones
              const SizedBox(width: 10),
              // Botón Guardar a la derecha
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Botón de "Guardar" azul
                  minimumSize: Size(120, 40), // Tamaño adecuado para los botones
                ),
                onPressed: () {
                  // Función para guardar la empresa y mostrar la ventana emergente
                  _showConfirmationDialog(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
          const Spacer(), // Esto empuja el Footer hacia abajo
          Footer(), // Footer en la parte inferior
        ],
      ),
    );
  }
}