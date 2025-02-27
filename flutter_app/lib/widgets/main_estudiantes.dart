import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeEstudianteScreen.dart';
import 'package:flutter_app/screens/chat_estudiante_screen.dart';
import 'package:flutter_app/screens/mis_postulaciones_screen.dart';
import 'package:flutter_app/screens/perfil_estudiante_screen.dart';
import 'package:flutter_app/widgets/header.dart';

class MainEstudiantes extends StatefulWidget {
  const MainEstudiantes({super.key});

  @override
  State<MainEstudiantes> createState() => _MainEstudiantesState();
}

class _MainEstudiantesState extends State<MainEstudiantes> {
  int currentIndex = 0;
  void goToPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeEstudianteScreen(),
    MisPostulacionesScreen(),
    ChatScreen(),
    PerfilEstudianteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Column(
          children: const [Header()],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: colors.onPrimaryContainer,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Mis Postulaciones',
              backgroundColor: colors.onSecondaryContainer),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
              backgroundColor: colors.onTertiaryContainer),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: colors.onPrimaryFixedVariant),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: goToPage,
      ),
    );
  }
}
