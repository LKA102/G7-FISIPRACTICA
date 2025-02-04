import 'package:flutter/material.dart';
import '../screens/home_admin_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform login logic
      print('Email: $_email, Password: $_password');
      // Navegar a HomeScreen después de iniciar sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 275.39,
            height: 75,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Código admin',
                filled: true,
                fillColor: Color(0xFFDBE2F6),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1E3984), width: 1.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1E3984), width: 1.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: 275.39,
            height: 75,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Contraseña admin',
                filled: true,
                fillColor: Color(0xFFDBE2F6),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1E3984), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1E3984), width: 1.0),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: 150, // Establece el ancho del botón
            height: 48, // Establece la altura del botón
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E3984), // Fondo azul
                foregroundColor: Color(0xFFF5F5F5), // Color del texto
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Ingresar'),
            ),
          ),
        ],
      ),
    );
  }
}