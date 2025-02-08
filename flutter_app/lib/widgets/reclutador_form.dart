import 'package:flutter/material.dart';

class ReclutadorFormWidget extends StatefulWidget {
  final List<String> empresas;

  const ReclutadorFormWidget({
    Key? key,
    required this.empresas,
  }) : super(key: key);

  @override
  _ReclutadorFormWidgetState createState() => _ReclutadorFormWidgetState();
}

class _ReclutadorFormWidgetState extends State<ReclutadorFormWidget> {
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  DateTime? _fechaInicio;
  String _empresaSeleccionada = '';

  void _selectFechaInicio(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _fechaInicio) {
      setState(() {
        _fechaInicio = picked;
      });
    }
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
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(Icons.check, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Se ha guardado los cambios',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Ir a inicio'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nombresController,
          decoration: const InputDecoration(
            labelText: 'Nombres',
            filled: true,
            fillColor: Color(0xFFE6F2FF),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _apellidosController,
          decoration: const InputDecoration(
            labelText: 'Apellidos',
            filled: true,
            fillColor: Color(0xFFE6F2FF),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _correoController,
          decoration: const InputDecoration(
            labelText: 'Correo electrónico',
            filled: true,
            fillColor: Color(0xFFE6F2FF),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _contrasenaController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            filled: true,
            fillColor: Color(0xFFE6F2FF),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F2FF),
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
              const DropdownMenuItem<String>(
                value: null,
                child: Text('Seleccionar empresa', style: TextStyle(color: Colors.grey)),
              ),
              ...widget.empresas.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
            ],
            hint: const Text('Seleccionar empresa', style: TextStyle(color: Colors.grey)),
            isExpanded: true,
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _descripcionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Descripción',
            filled: true,
            fillColor: Color(0xFFE6F2FF),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Fecha de inicio:'),
            TextButton(
              onPressed: () => _selectFechaInicio(context),
              child: Text(_fechaInicio == null ? 'Seleccionar' : "${_fechaInicio?.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _guardarReclutador,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ],
    );
  }
}