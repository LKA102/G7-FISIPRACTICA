import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_estudiante.dart';

class PerfilEstudianteScreen extends StatefulWidget {
  const PerfilEstudianteScreen({super.key});

  @override
  State<PerfilEstudianteScreen> createState() => _PerfilEstudianteScreenState();
}

class _PerfilEstudianteScreenState extends State<PerfilEstudianteScreen> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const Header(),
      ),
      body:  */
        Column(
      children: [
        Expanded(
          child: _currentPage == 1 ? _buildPage1() : _buildPage2(),
        ),
        _buildPagination(),
      ],
    ) /* ,
      bottomNavigationBar: const Footer(),
    ) */
        ;
  }

  Widget _buildPage1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(radius: 50, backgroundColor: Colors.grey[300]),
          const SizedBox(height: 10),
          _buildEditableField("Nombre", "Maria"),
          _buildEditableField("Apellido", "Soto Flores"),
          _buildEditableField("Correo", "mariasoto19@gmail.com"),
          _buildEditableField("Contraseña", "**********", isPassword: true),
          _buildDropdown("Universidad"),
          Row(
            children: [
              Expanded(child: _buildDateField("Fecha de inicio")),
              const SizedBox(width: 10),
              Expanded(child: _buildDateField("Fecha fin")),
            ],
          ),
          _buildToggle("Actualmente estoy en la universidad"),
          _buildEditableField("Descripción", "", isLarge: true),
        ],
      ),
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDropdown("Tecnologías"),
          _buildTagList(["Html", "Css", "Javascript"]),
          _buildDropdown("Disponibilidad"),
          _buildToggle("Inmediata"),
          _buildToggle("1 mes - 2 meses"),
          _buildToggle("> 2 meses"),
          _buildFileUpload("Adjuntar CV"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("Cancelar", Colors.red),
              _buildButton("Guardar", Colors.blue[900]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => setState(() => _currentPage = 1),
            child: Text(
              "1",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _currentPage == 1 ? Colors.blue[900] : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => _currentPage = 2),
            child: Text(
              "2",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _currentPage == 2 ? Colors.blue[900] : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value,
      {bool isPassword = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        obscureText: isPassword,
        maxLines: isLarge ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: const Icon(Icons.edit, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: const [DropdownMenuItem(child: Text("Opción 1"), value: "1")],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildDateField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
      ),
    );
  }

  Widget _buildToggle(String label) {
    return SwitchListTile(
      title: Text(label),
      value: false,
      onChanged: (value) {},
    );
  }

  Widget _buildFileUpload(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: const Icon(Icons.attach_file, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildTagList(List<String> tags) {
    return Wrap(
      spacing: 8.0,
      children:
          tags.map((tag) => Chip(label: Text(tag), onDeleted: () {})).toList(),
    );
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
