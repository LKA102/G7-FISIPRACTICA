//Pantalla de bienvenida
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pick_user_screen.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E3984),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo_blanco.png',
              height: 208,
              width: 211,
            ),
            SizedBox(height: 20),
            _showButton
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PickUserScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E1D94),
                      foregroundColor: Color(0xFFDEDEFF),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          )),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      minimumSize: const Size(180, 50),
                    ),
                    child: const Text('¡Vamos!'),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
