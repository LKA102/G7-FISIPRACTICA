import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'estudiantes_screen.dart';
import 'admin_empresa_screen.dart';
import 'reclutadores_screen.dart';

class HomeEstudiante extends StatefulWidget {
  @override
  _HomeEstudianteState createState() => _HomeEstudianteState();
}

class _HomeEstudianteState extends State<HomeEstudiante> {
  int _selectedIndex = 0;

  // Lista de pantallas a las que se puede navegar
  final List<Widget> _pages = [
    EstudiantesScreen(),
    AdminEmpresaScreen(),
    ReclutadoresScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Ajusta la altura del header
        child: Header(), // Usa el widget reutilizable del Header
      ),
      body: _pages[_selectedIndex], // Muestra la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Estudiantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Empresas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Reclutadores',
          ),
        ],
      ),
    );
  }
}
