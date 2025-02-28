import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat_reclutador_screen.dart';
import 'package:flutter_app/screens/home_reclutador_screen.dart';
import 'package:flutter_app/screens/ofertas_reclutador_screen.dart';
import 'package:flutter_app/widgets/header.dart';


class MainReclutadores extends StatefulWidget {
  const MainReclutadores({super.key});

  @override
  State<MainReclutadores> createState() => _MainReclutadoresState();
}

class _MainReclutadoresState extends State<MainReclutadores> {
  int currentIndex = 0;
  void goToPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeReclutadorScreen(),
    OfertasReclutadorScreen(),
    ChatReclutadorScreen()
  ];

  @override
  Widget build(BuildContext context){
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), 
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
          backgroundColor: Color(0xFF1E3984),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home_icon.png',
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/portfolio_icon.png',
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: 'Ofertas',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/chatbot_icon.png',
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
              label: 'Chat',
            )
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: goToPage,
        ),
    );
  }

}