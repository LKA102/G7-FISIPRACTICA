import 'package:flutter/material.dart';
import 'screens/HomeEstudianteScreen.dart';
import 'screens/mis_postulaciones_screen.dart';
//import 'screens/chatbot_screen.dart';
//import 'screens/perfil_screen.dart';

void main() {
  //runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Agrega "const"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Aplicación',
      initialRoute: '/homeEstudiante', // Pantalla inicial
      routes: {
        '/homeEstudiante': (context) => HomeEstudianteScreen(),
        '/misPostulaciones': (context) => MisPostulacionesScreen(),
        //'/chatbot': (context) => ChatbotScreen(),
        //'/perfil': (context) => PerfilScreen(),
      },
    );
  }
}
