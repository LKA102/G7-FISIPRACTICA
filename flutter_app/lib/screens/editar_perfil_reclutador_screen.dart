import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'editar_ofertas_screen.dart';

class EditarReclutadorScreen extends StatefulWidget {
  final Map<String, String> reclutador;

  const EditarReclutadorScreen({super.key, required this.reclutador});

  @override
  _EditarReclutadorScreenState createState() => _EditarReclutadorScreenState();
}

class _EditarReclutadorScreenState extends State<EditarReclutadorScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late TextEditingController _passwordController;
  late TextEditingController _descripcionController;
  late TextEditingController _fechaController;
  String _empresaSeleccionada = 'Adecco'; // Empresa seleccionada
  bool _passwordVisible = false; // Control de visibilidad de la contraseña

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.reclutador['nombre']);
    _apellidoController = TextEditingController(text: widget.reclutador['apellido']);
    _correoController = TextEditingController(text: widget.reclutador['correo']);
    _passwordController = TextEditingController(text: '********');
    _descripcionController = TextEditingController(text: widget.reclutador['descripcion']);
    _fechaController = TextEditingController(text: widget.reclutador['fecha_nacimiento']);
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

  void _seleccionarFecha() async {
    DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        _fechaController.text = "${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}";
      });
    }
  }

  void _guardarCambios() {
    // Aquí puedes agregar la lógica para guardar los cambios antes de navegar
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => EditarOfertasScreen()),
    );
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
                  backgroundImage: AssetImage('assets/profile_picture.jpg'), // Ruta de la imagen de perfil
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: () {
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
            _buildEditableField('Correo Electrónico', _correoController, isEmail: true),
            
            // Campo de contraseña con visibilidad controlada
            TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
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
              value: _empresaSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  _empresaSeleccionada = newValue!;
                });
              },
              items: ['Adecco', 'Manpower', 'Randstad', 'Consultora XYZ']
                  .map<DropdownMenuItem<String>>((String empresa) {
                return DropdownMenuItem<String>(
                  value: empresa,
                  child: Text(empresa),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Empresa'),
            ),
            SizedBox(height: 10),

            // Descripción (Textarea)
            _buildEditableField('Descripción', _descripcionController, maxLines: 3),

            // Fecha de nacimiento con icono de calendario
            TextFormField(
              controller: _fechaController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => EditarOfertasScreen()),
                    );
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

  Widget _buildEditableField(String label, TextEditingController controller, {bool isEmail = false, int maxLines = 1}) {
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