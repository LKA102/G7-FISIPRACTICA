import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/empresas_services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/footer.dart';
import '../widgets/header.dart';
import 'admin_empresa_screen.dart'; // Asegúrate de importar la pantalla donde deseas regresar.

class CrearEmpresaScreen extends StatefulWidget {
  const CrearEmpresaScreen({super.key});

  @override
  State<CrearEmpresaScreen> createState() => _CrearEmpresaScreenState();
}

class _CrearEmpresaScreenState extends State<CrearEmpresaScreen> {
  File? file;
  late TextEditingController _name;
  late TextEditingController _address;
  late TextEditingController _description;
  late TextEditingController _website;
  late TextEditingController _location;
  Color _selectedColor = Colors.blue; // Color seleccionado

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _address = TextEditingController();
    _description = TextEditingController();
    _website = TextEditingController();
    _location = TextEditingController();
  }

  void _showSuccessDialog() {
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
                  textStyle: const TextStyle(
                      fontSize: 18), // Ajuste de tamaño de texto
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

  // Función para mostrar el cuadro de confirmación
  void _showConfirmationDialog() async {
    final body = {
      'name': _name.text,
      'address': _address.text,
      'description': _description.text,
      'website': _website.text,
      'location': _location.text,
      'color': _selectedColor // Guardar el color seleccionado
    };
    try {
      final response = await EmpresaServices.registerEmpresa(body, file);
      print(response);
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
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
                  Icons.error,
                  color: Colors.red, // Color del ícono
                  size: 60, // Tamaño del ícono ajustado
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ha ocurrido un error',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22, // Aumento del tamaño del texto
                    color: Colors.red, // Texto en rojo
                  ),
                ),
              ],
            ),
            content: const Text(
              'Por favor, intenta de nuevo.',
              style: TextStyle(
                fontSize: 18, // Aumento del tamaño del texto
              ),
            ),
            actions: <Widget>[
              // Botón "Cerrar"
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Color rojo del botón
                    minimumSize: Size(180, 50), // Tamaño adecuado para el botón
                    textStyle: const TextStyle(
                        fontSize: 18), // Ajuste de tamaño de texto
                  ),
                  onPressed: () {
                    // Cerrar la ventana emergente
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Seleccionar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 40,
                backgroundImage: file != null
                    ? FileImage(file!)
                    : AssetImage(
                        'assets/office-building.png'), // Ruta de la imagen de perfil
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: () async {
                    file = null;
                    final picker = ImagePicker();
                    final result = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (result != null) {
                      // Archivo seleccionado
                      setState(() {
                        file = File(result.path);
                      });
                      print('Archivo seleccionado: $file');
                    } else {
                      // El usuario canceló la selección
                      print('No se seleccionó ningún archivo');
                    }
                    // Lógica para cambiar la imagen de perfil
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: 'Nombre de la Empresa',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _description,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _address,
                      decoration: InputDecoration(
                        labelText: 'Dirección',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _website,
                      decoration: InputDecoration(
                        labelText: 'Sitio Web',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _location,
                      decoration: InputDecoration(
                        labelText: 'Ubicación',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Botón para seleccionar color
                    Container(
                      /* 
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: const Color.fromARGB(255, 77, 77, 77),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Color Representativo:',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: _showColorPickerDialog,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _selectedColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ])),
          const SizedBox(height: 20),
          // Alineación de los botones "Guardar" y "Cancelar"
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
            children: <Widget>[
              // Botón Cancelar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Botón de "Cancelar" gris
                  minimumSize:
                      Size(120, 40), // Tamaño adecuado para los botones
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
                  minimumSize:
                      Size(120, 40), // Tamaño adecuado para los botones
                ),
                onPressed: () {
                  // Función para guardar la empresa y mostrar la ventana emergente
                  _showConfirmationDialog();
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
