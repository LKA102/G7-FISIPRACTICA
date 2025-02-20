import 'package:flutter/material.dart';
import 'package:flutter_app/screens/splah_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'screens/HomeEstudianteScreen.dart';
//import 'screens/mis_postulaciones_screen.dart';
//import 'screens/chatbot_screen.dart';
//import 'screens/perfil_screen.dart';

/*void main() {
  //runApp(MyApp());
  runApp(const MyApp());
}*/
void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Agrega "const"*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*@override
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
  }*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3984)),
        useMaterial3: true,
      ),
      home:
          const SplahScreen(), //Lleva donde se define ese widget - primera pantalla en mostrarse
    );
  }
}
