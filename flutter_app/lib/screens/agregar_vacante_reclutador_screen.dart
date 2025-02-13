import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_reclutador.dart';

class AgregarVacanteReclutadorScreen extends StatefulWidget {
  const AgregarVacanteReclutadorScreen({super.key});

  @override
  _AgregarVacanteReclutadorScreenState createState() => _AgregarVacanteReclutadorScreenState();
}

class _AgregarVacanteReclutadorScreenState extends State<AgregarVacanteReclutadorScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _sedeController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _conocimientosController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();

  void _mostrarDialogoGuardado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Éxito"),
          content: const Text("Se ha guardado los cambios"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.of(context).pop(); // Regresar a la pantalla anterior
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Ir a inicio", style: TextStyle(color: Colors.white)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Nombre de la vacante", _nombreController),
            _buildTextField("Sede", _sedeController),
            _buildTextField("Descripción", _descripcionController),
            _buildTextField("Conocimientos", _conocimientosController),
            _buildTextField("Requisitos", _requisitosController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _mostrarDialogoGuardado,
                  child: const Text("Guardar", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.blue.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
