import 'package:flutter/material.dart';
import '../widgets/header.dart';  // Asegúrate de tener este archivo
import '../widgets/footer.dart';  // Asegúrate de tener este archivo

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
  final TextEditingController _fechaInicioController = TextEditingController();
  String _empresaSeleccionada = 'Banco de Crédito del Perú'; // Por ejemplo, el valor inicial.

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

  void _guardarReclutador() {
    // Aquí puedes agregar la lógica para guardar los datos del reclutador
    print('Reclutador guardado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(), // Incluye el header aquí
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Editar Reclutador', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3984))),
            SizedBox(height: 20),
            TextField(
              controller: _nombresController,
              decoration: InputDecoration(labelText: 'Nombres'),
            ),
            TextField(
              controller: _apellidosController,
              decoration: InputDecoration(labelText: 'Apellidos'),
            ),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _contrasenaController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            DropdownButton<String>(
              value: _empresaSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  _empresaSeleccionada = newValue!;
                });
              },
              items: empresas.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              hint: Text('Selecciona una empresa'),
            ),
            TextField(
              controller: _descripcionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _fechaInicioController,
              decoration: InputDecoration(labelText: 'Fecha de inicio (yyyy-mm-dd)'),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción de cancelar
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
      bottomNavigationBar: Footer(), // Incluye el footer aquí
    );
  }
}


