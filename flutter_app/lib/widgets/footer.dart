import 'package:flutter/material.dart';
import '../screens/editar_ofertas_screen.dart'; 
import '../screens/home_admin_screen.dart';
import '../screens/editar_admin_screen.dart'; 

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;

  // Función que maneja el tap en el footer y redirige al portafolio, al home o a la pantalla de editar admin
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });

    // Si el índice corresponde al Portafolio (índice 1)
    if (_selectedIndex == 1) {
      // Navegar hacia la pantalla de 'editar_ofertas_screen'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EditarOfertasScreen()), 
      );
    }

    // Si el índice corresponde al Home (índice 0)
    else if (_selectedIndex == 0) {
      // Navegar hacia la pantalla de 'home_admin_screen'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), 
      );
    }

    // Si el índice corresponde al Usuario (índice 2)
    else if (_selectedIndex == 2) {
      // Navegar hacia la pantalla de 'editar_admin_screen'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EditarAdminScreen()), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E3984),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Home Icon
          IconButton(
            icon: Image.asset(
              'assets/home_icon.png',
              color: _selectedIndex == 0 ? Colors.white : Colors.grey, 
            ),
            onPressed: () {
              _onItemTapped(0); 
            },
          ),
          
          // Portafolio Icon
          IconButton(
            icon: Image.asset(
              'assets/portfolio_icon.png',
              color: _selectedIndex == 1 ? Colors.white : Colors.grey, 
            ),
            onPressed: () {
              _onItemTapped(1); 
            },
          ),
          
          // User Icon
          IconButton(
            icon: Image.asset(
              'assets/user_icon.png',
              color: _selectedIndex == 2 ? Colors.white : Colors.grey, 
            ),
            onPressed: () {
              _onItemTapped(2); 
            },
          ),
        ],
      ),
    );
  }
}