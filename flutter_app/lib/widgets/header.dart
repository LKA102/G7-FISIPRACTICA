import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/admin_login_form.dart';

class Header extends StatelessWidget {
  final bool isHome;
  const Header({super.key, this.isHome = false});

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: SizedBox(
            width: 321,
            height: 387,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'),
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
                Expanded(child: AdminLoginForm()),
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
    final colors = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AppBar(
          backgroundColor: colors.surface,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () => _showLoginDialog(context),
              child: Image.asset(
                'assets/logo.png',
                height: 60,
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF1E3984),
              size: 40.0,
            ),
            onPressed: () {
              if (!isHome) Navigator.pop(context);
            },
          ),
        ));
    /* Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF1E3984),
              size: 40.0,
            ),
            onPressed: () {
              if (!isHome) Navigator.pop(context);
            },
          ),
          GestureDetector(
              onTap: () => _showLoginDialog(context),
              child: Image.asset(
                'assets/logo.png',
                height: 60,
              )),
        ],
      ),
    ); */
  }
}
