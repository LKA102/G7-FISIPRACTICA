import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/pick_user_card.dart';
import '../widgets/header.dart';
import 'package:flutter_app/screens/login_screen.dart';

class PickUserScreen extends StatefulWidget {
  const PickUserScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_PickUserScreen();
}

class _PickUserScreen extends State<PickUserScreen>{
  late int _selectedButtonIndex;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    //TODO: Save the selected user type for future use
    if (_selectedButtonIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (_selectedButtonIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedButtonIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "¿Quién soy?",
                  style: TextStyle(
                    color: Color(0xff1E3984),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                   )
                 ),
                SizedBox(height: 20),
                PickUserCard(title: "Reclutador", imagePath: 'assets/recruiter_login_image.jpg', onPressed: (){
                  _onButtonPressed(0);
                }),
                SizedBox(height: 20),
                PickUserCard(title: "Estudiante", imagePath: 'assets/student_login_image.jpg', onPressed: (){
                  _onButtonPressed(1);
                }),
              ],
            ), 
          )
        ],
      ),
    );
  }
}