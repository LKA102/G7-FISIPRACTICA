//Punto de entrada de la aplicación
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/splah_screen.dart';

void main() {
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
      home:
          const SplahScreen(), //Lleva donde se define ese widget - primera pantalla en mostrarse
    );
  }
}
