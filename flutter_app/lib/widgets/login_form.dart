import 'package:flutter/material.dart';
import '../screens/register_screen.dart'; 
import '../screens/reinicio_contraseña_screen.dart';
import '../screens/home_reclutador_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: $_email, Password: $_password');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeReclutadorScreen()),
      );
    }
  }

  @override
  void initState() {
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logo_azul.png',
              height: 208,
              width: 211,
            ),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: pepito@unmsm.edu.pe',
                label: Text("Correo electrónico o telefono")
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: 123456',
                label: Text("Contraseña")
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _submit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E3984),
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.black.withAlpha(128),
                elevation: 10,
              ),
              child: Text('Iniciar sesión'),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Aun no eres usuario?', style: TextStyle(fontSize: 14)),
                TextButton(
                  onPressed: () {
                    // Navegar a la pantalla de registro
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Registrate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
             onPressed: () {
              Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
          );
         },
  child: const Text('Olvidaste tu contraseña?'),
)
          ]
        ),
      ),
    );
  }
}
