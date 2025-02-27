import 'package:flutter/material.dart';
import '../screens/home_reclutador_screen.dart'; // Pantalla principal del reclutador
import '../screens/ofertas_reclutador_screen.dart';
import '../screens/chat_reclutador_screen.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, Widget screen) {
    setState(() {
      _selectedIndex = index;
    });

    // Evita recargar la misma pantalla si ya está seleccionada
    if (ModalRoute.of(context)?.settings.name != screen.runtimeType.toString()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3984),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/home_icon.png',
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(0, const HomeReclutadorScreen()), // Aquí debe ir la pantalla de inicio
          ),
          IconButton(
            icon: Image.asset(
              'assets/portfolio_icon.png',
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(1, const OfertasReclutadorScreen()),
          ),
          IconButton(
            icon: Image.asset(
              'assets/chatbot_icon.png',
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            onPressed: () => _onItemTapped(2, const ChatReclutadorScreen()),
          ),
        ],
      ),
    );
  }
}
