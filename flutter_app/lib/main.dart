import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeEstudianteScreen.dart';
import 'package:flutter_app/screens/home_reclutador_screen.dart';
import 'package:flutter_app/screens/splah_screen.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_app/widgets/main_estudiantes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3984)),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: UserServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            final user = snapshot.data as Map<String, dynamic>;
            if (user['role'] == 'Estudiante') {
              return const MainEstudiantes();
            } else if (user['role'] == 'Reclutador') {
              return const HomeReclutadorScreen();
            } else {
              return const SplahScreen();
            }
          } else {
            return const SplahScreen();
          }
        },
      ), //Lleva donde se define ese widget - primera pantalla en mostrarse
    );
  }
}
