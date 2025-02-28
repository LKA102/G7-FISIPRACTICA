import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/empresas_services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'reclutadores_screen.dart';
import '../services/reclutadores_services.dart';

class EditarReclutadorScreen extends StatefulWidget {
  final Map<String, dynamic> reclutador;

  const EditarReclutadorScreen({super.key, required this.reclutador});

  @override
  _EditarReclutadorScreenState createState() => _EditarReclutadorScreenState();
}

class _EditarReclutadorScreenState extends State<EditarReclutadorScreen> {
  Uint8List? photo;
  File? file;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late TextEditingController _passwordController;
  late TextEditingController _descripcionController;
  late TextEditingController _fechaController;
  String? _empresaSeleccionada;
  bool _passwordVisible = false;

  List<dynamic> empresas = [];

  @override
  void initState() {
    super.initState();
    photo = widget.reclutador['foto'];
    _nombreController =
        TextEditingController(text: widget.reclutador['nombre']);
    _apellidoController =
        TextEditingController(text: widget.reclutador['apellido']);
    _correoController =
        TextEditingController(text: widget.reclutador['correo']);
    _passwordController = TextEditingController(text: '********');
    _descripcionController =
        TextEditingController(text: widget.reclutador['descripcion']);
    _fechaController =
        TextEditingController(text: widget.reclutador['fecha_inicio']);
    _fetchEmpresas();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  void _fetchEmpresas() async {
    List<Map<String, dynamic>> fetchedEmpresas =
        await EmpresaServices.getEmpresas();
    setState(() {
      empresas = fetchedEmpresas
          .map((empresa) => {'id': empresa['id'], 'name': empresa['nombre']})
          .toList();
      print(empresas);
    });
  }

  void _seleccionarFecha() async {
    DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        _fechaController.text = fechaSeleccionada.toString().substring(0, 10);
      });
    }
  }

  void _mostrarVentanaEmergente() {
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
                color: Colors.blue,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'Se ha guardado los cambios',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color.fromARGB(255, 8, 76, 131),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // Botón "Ir a inicio"
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(180, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReclutadoresScreen()), // Redirige a ReclutadoresScreen
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

  void _guardarCambios() async {
    try {
      final body = {
        'first_name': _nombreController.text,
        'last_name': _apellidoController.text,
        'email': _correoController.text,
        'description': _descripcionController.text,
        'position_start_date': _fechaController.text,
        'company_id': int.parse(_empresaSeleccionada ?? '0'),
      };
      final response = await ReclutadoresServices.updateReclutador(
          widget.reclutador['id'], body);
      print(response);
      if (mounted) {
        _mostrarVentanaEmergente();
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
                Text(
                  "$e",
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
      // Manejar el error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de perfil con botón de edición
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: photo != null
                      ? MemoryImage(photo!)
                      : file != null
                          ? FileImage(file!)
                          : AssetImage(
                              'assets/profile_picture.jpg'), // Ruta de la imagen de perfil
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: () async {
                      photo = null;
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
            SizedBox(height: 20),

            // Campos de información
            _buildEditableField('Nombre', _nombreController),
            _buildEditableField('Apellido', _apellidoController),
            _buildEditableField('Correo Electrónico', _correoController,
                isEmail: true),

            // Campo de contraseña con visibilidad controlada
            TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            // Selección de empresa (Dropdown)
            DropdownButtonFormField<String>(
              value: _empresaSeleccionada?.isEmpty ?? true
                  ? null
                  : _empresaSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  _empresaSeleccionada = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                    value: null,
                    child: Text('Seleccionar empresa',
                        style: TextStyle(color: Colors.grey))),
                ...empresas.map<DropdownMenuItem<String>>((dynamic empresa) {
                  return DropdownMenuItem<String>(
                      value: empresa['id'].toString(),
                      child: Text(empresa['name']));
                }),
              ],
              decoration: InputDecoration(labelText: 'Empresa'),
            ),
            SizedBox(height: 10),

            // Descripción (Textarea)
            _buildEditableField('Descripción', _descripcionController,
                maxLines: 3),

            // Fecha de nacimiento con icono de calendario
            TextFormField(
              controller: _fechaController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha de Inicio',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _seleccionarFecha,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(
                        context); // Regresar a la pantalla anterior sin guardar
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _guardarCambios,
                  child: Text('Guardar Cambios'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool isEmail = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.edit),
      ),
    );
  }
}
