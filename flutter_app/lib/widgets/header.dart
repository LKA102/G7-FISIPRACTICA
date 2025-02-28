import 'package:flutter/material.dart';
import 'package:flutter_app/screens/splah_screen.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_app/widgets/admin_login_form.dart';

class Header extends StatelessWidget {
  final bool isHome;
  final bool allowedAdminLogin;
  const Header({super.key, this.isHome = false, this.allowedAdminLogin = false});

  Future<void> _logout() async {
    try {
      await UserServices.logout();
    } catch (e) {
      rethrow;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: SizedBox(
              width: 150,
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Seguro que deseas cerrar sesión?',
                    style: TextStyle(
                      color: Color(0xFF1E3984),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E3984),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Cerrar'),
                        onPressed: () async {
                          try {
                            await _logout();
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplahScreen()),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF1E3984),
                          side: BorderSide(color: Color(0xFF1E3984)),
                        ),
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AppBar(
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () => { if (allowedAdminLogin) _showLoginDialog(context) },
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
              if (!isHome) {
                Navigator.pop(context);
              } else {
                _showLogoutDialog(context);
              }
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
