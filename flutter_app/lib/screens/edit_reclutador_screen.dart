import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class EditReclutadorScreen extends StatefulWidget {
  const EditReclutadorScreen({super.key});

  @override
  _EditReclutadorScreenState createState() => _EditReclutadorScreenState();
}

class _EditReclutadorScreenState extends State<EditReclutadorScreen> {
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  DateTime? _fechaInicio;
  String _empresaSeleccionada = ''; // Valor inicial vacío

  List<String> empresas = [
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
    'Tottus',
  ];

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

  void _guardarReclutador() {
    print('Reclutador guardado');

    _showConfirmationDialog();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Crear Reclutador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3984)),
            ),
            SizedBox(height: 20),
            // Foto de perfil
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF1E3984),
              child: IconButton(
                onPressed: () {
                },
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
                value: _empresaSeleccionada.isEmpty ? null : _empresaSeleccionada,
                onChanged: (String? newValue) {
                  setState(() {
                    _empresaSeleccionada = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem<String>(value: null, child: Text('Seleccionar empresa', style: TextStyle(color: Colors.grey))),
                  ...empresas.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ],
                hint: Text('Seleccionar empresa', style: TextStyle(color: Colors.grey)),
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
                  child: Text(_fechaInicio == null ? 'Seleccionar' : "${_fechaInicio?.toLocal()}".split(' ')[0]),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: _guardarReclutador, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(), 
    );
  }
}