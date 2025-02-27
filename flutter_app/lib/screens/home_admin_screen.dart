import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'estudiantes_screen.dart';
import 'admin_empresa_screen.dart';
import 'reclutadores_screen.dart'; 

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
    } else if (index == 1) {
      // Navegar a la pantalla de Reclutadores
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReclutadoresScreen()),  // Navega a ReclutadoresScreen
      );
    } else if (index == 2) {
      // Navegar a la pantalla de Empresas
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminEmpresaScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(isHome: true),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 363,
                    height: 79,
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(0);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 0
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5),
                        foregroundColor: _selectedButtonIndex == 0
                            ? Color(0xFFF5F5F5)
                            : Colors.white,
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128),
                        elevation: 10,
                      ),
                      child: Text('Estudiantes'),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 363,
                    height: 79,
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 1
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5),
                        foregroundColor: _selectedButtonIndex == 1
                            ? Color(0xFFF5F5F5)
                            : Colors.white,
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128),
                        elevation: 10,
                      ),
                      child: Text('Reclutadores'),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 363,
                    height: 79,
                    child: ElevatedButton(
                      onPressed: () {
                        _onButtonPressed(2);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtonIndex == 2
                            ? Color(0xFF1E3984)
                            : Color(0xFFD5D5D5),
                        foregroundColor: _selectedButtonIndex == 2
                            ? Color(0xFFF5F5F5)
                            : Colors.white,
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128),
                        elevation: 10,
                      ),
                      child: Text('Empresas'),
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
