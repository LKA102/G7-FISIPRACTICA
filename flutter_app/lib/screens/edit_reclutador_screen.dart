import 'package:flutter/material.dart';

class EditReclutadorScreen extends StatelessWidget {
  final Map<String, String> reclutador;

  const EditReclutadorScreen({Key? key, required this.reclutador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreController = TextEditingController(text: reclutador['nombre']);
    TextEditingController empresaController = TextEditingController(text: reclutador['empresa']);
    TextEditingController experienciaController = TextEditingController(text: reclutador['experiencia']);
    TextEditingController fechaController = TextEditingController(text: reclutador['fecha']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Reclutador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: empresaController,
              decoration: InputDecoration(labelText: 'Empresa'),
            ),
            TextField(
              controller: experienciaController,
              decoration: InputDecoration(labelText: 'Años de Experiencia'),
            ),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(labelText: 'Fecha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para guardar los cambios.
                // Por ejemplo, puedes actualizar la lista de reclutadores en la pantalla anterior.
                Navigator.pop(context);
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}