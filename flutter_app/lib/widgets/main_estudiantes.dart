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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Column(
          children: const [Header(isHome: true)],
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
            icon: Image.asset(
              'assets/home_icon.png',
              color: currentIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: 'Inicio',
            backgroundColor: Color(0xFF1E3984),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/portfolio_icon.png',
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: 'Mis Postulaciones',
              backgroundColor: Color(0xFF1E3984)),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/chatbot_icon.png',
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
              label: 'Chat',
              backgroundColor: Color(0xFF1E3984)),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/user_icon.png',
                color: currentIndex == 3 ? Colors.white : Colors.grey,
              ),
              label: 'Perfil',
              backgroundColor: Color(0xFF1E3984)),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: goToPage,
      ),
    );
  }
}
