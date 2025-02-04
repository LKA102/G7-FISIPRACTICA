import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            width: 321,
            height: 387,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'), // Asegúrate de tener la imagen en la carpeta assets
                ),
                SizedBox(height: 20),
                Text(
                  'Admin Admin',
                  style: TextStyle(
                    color: Color(0xFF1E3984),
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(child: LoginForm()),
              ],
            ),
          ),
          /*actions: <Widget>[
            TextButton(
              child: Text(
                'Cerrar',
                style: TextStyle(
                  color: Color(0xFF1E3984),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],*/
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Cambia el color de fondo aquí
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0,
            offset: Offset(0, 3), // Cambia la posición de la sombra
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF1E3984),// Cambia el color del icono aquí
              size: 40.0, // Cambia el tamaño del icono aquí
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            onTap: () => _showLoginDialog(context),
            child: Image.asset(
              'assets/logo.png',
              height: 60,
            )
          ),
        ],
      ),
    );
  }
}