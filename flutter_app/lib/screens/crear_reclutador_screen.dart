import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/reclutador_form.dart';

class EditReclutadorScreen extends StatefulWidget {
  const EditReclutadorScreen({super.key});

  @override
  _EditReclutadorScreenState createState() => _EditReclutadorScreenState();
}

class _EditReclutadorScreenState extends State<EditReclutadorScreen> {
  final List<String> empresas = [
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Crear Reclutador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3984)),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF1E3984),
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // **Formulario**
            Expanded(
              child: ReclutadorFormWidget(empresas: empresas),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}