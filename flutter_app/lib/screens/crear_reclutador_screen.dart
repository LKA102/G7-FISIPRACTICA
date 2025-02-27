import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import 'package:flutter_app/services/empresas_services.dart';
import 'package:flutter_app/services/reclutadores_services.dart';

import '../widgets/footer.dart';
import '../widgets/header.dart';

class EditReclutadorScreen extends StatefulWidget {
  const EditReclutadorScreen({super.key});

  @override
  _EditReclutadorScreenState createState() => _EditReclutadorScreenState();
}

class _EditReclutadorScreenState extends State<EditReclutadorScreen> {
  late TextEditingController _nombresController;
  late TextEditingController _apellidosController;
  late TextEditingController _correoController;
  late TextEditingController _contrasenaController;
  late TextEditingController _descripcionController;
  DateTime? _fechaInicio;
  String? _empresaSeleccionada; // Valor inicial null

  List<dynamic> empresas = [
    /* 
    'Banco de Crédito del Perú',
    'Interbank',
    'BBVA',
    'Scotiabank',
    'MiBanco',
    'Alicorp',
    'Backus',
    'Cemex Perú',
    'Corporación Lindley',
    'Ferreyros',
    'Cosapi',
    'Southern Copper Corporation',
    'Claro Perú',
    'Inca Kola',
    'Tottus', */
  ];

  @override
  void initState() {
    _nombresController = TextEditingController(text: '');
    _apellidosController = TextEditingController(text: '');
    _correoController = TextEditingController(text: '');
    _contrasenaController = TextEditingController(text: '');
    _descripcionController = TextEditingController(text: '');
    super.initState();
    _fetchEmpresas();
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

  void _selectFechaInicio(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _fechaInicio)
      setState(() {
        _fechaInicio = picked;
      });
  }

  void _guardarReclutador() async {
    try {
      final body = {
        'nombres': _nombresController.text,
        'apellidos': _apellidosController.text,
        'email': _correoController.text,
        'password': _contrasenaController.text,
        'empresa': int.parse(_empresaSeleccionada ?? '0'),
        'fecha_inicio': _fechaInicio.toString(),
        'descripcion': _descripcionController.text,
      };
      print(body);
      final response = await ReclutadoresServices.registerReclutador(body);
      print(response);
      print('Reclutador guardado');

      _showConfirmationDialog();
    } catch (e) {
      print(e);
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Se ha guardado los cambios',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Ir a inicio'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Crear Reclutador',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3984)),
              ),
              SizedBox(height: 20),
              // Foto de perfil
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF1E3984),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nombresController,
                decoration: InputDecoration(
                  labelText: 'Nombres',
                  filled: true,
                  fillColor: Color(0xFFE6F2FF),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _apellidosController,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  filled: true,
                  fillColor: Color(0xFFE6F2FF),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _correoController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  filled: true,
                  fillColor: Color(0xFFE6F2FF),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contrasenaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Color(0xFFE6F2FF),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE6F2FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: DropdownButton<String>(
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
                    ...empresas
                        .map<DropdownMenuItem<String>>((dynamic empresa) {
                      return DropdownMenuItem<String>(
                          value: empresa['id'].toString(), child: Text(empresa['name']));
                    }),
                  ],
                  hint: Text('Seleccionar empresa',
                      style: TextStyle(color: Colors.grey)),
                  isExpanded: true,
                  underline: Container(),
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Color(0xFFE6F2FF),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fecha de inicio:'),
                  TextButton(
                    onPressed: () => _selectFechaInicio(context),
                    child: Text(_fechaInicio == null
                        ? 'Seleccionar'
                        : "${_fechaInicio?.toLocal()}".split(' ')[0]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _guardarReclutador,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Guardar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
