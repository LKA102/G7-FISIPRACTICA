import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'estudiantes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedButtonIndex = -1;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EstudiantesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 363, // Establece el ancho del botón
                    height: 79, // Establece la altura del botón
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(0);
                        // Acción del primer botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 0
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5), // Color del botón
                        foregroundColor: _selectedButtonIndex == 0
                            ? Color(0xFFF5F5F5)
                            : Colors.white, // Color del texto
                        textStyle: TextStyle(
                          fontSize: 28, // Tamaño de la letra
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128), // Color de la sombra con opacidad
                        elevation: 10,
                      ),
                      child: Text('Estudiantes'),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 363, // Establece el ancho del botón
                    height: 79, // Establece la altura del botón
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(1);
                        // Acción del segundo botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 1
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5), // Color del botón
                        foregroundColor: _selectedButtonIndex == 1
                            ? Color(0xFFF5F5F5)
                            : Colors.white, // Color del texto
                        textStyle: TextStyle(
                          fontSize: 28, // Tamaño de la letra
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128), // Color de la sombra con opacidad
                        elevation: 10,
                      ),
                      child: Text('Profesores'),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 363, // Establece el ancho del botón
                    height: 79, // Establece la altura del botón
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(2);
                        // Acción del tercer botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 2
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5), // Color del botón
                        foregroundColor: _selectedButtonIndex == 2
                            ? Color(0xFFF5F5F5)
                            : Colors.white, // Color del texto
                        textStyle: TextStyle(
                          fontSize: 28, // Tamaño de la letra
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128), // Color de la sombra con opacidad
                        elevation: 10,
                      ),
                      child: Text('Administración'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}