import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_app/app/routes/routes.dart';
import 'package:flutter_app/app/widgets/pick_user_card.dart';
import 'package:get/get.dart';
import '../../../../widgets/header.dart';

class PickUserScreen extends GetView<AuthController> {
  const PickUserScreen({super.key});

  void _onButtonPressed(int index) {
      controller.setUserTypeIndex(0);
      Get.toNamed(AppRoutes.getLoginPage());
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
                PickUserCard(title: "Reclutador", imagePath: 'assets/images/recruiter_login_image.jpg', onPressed: (){
                  _onButtonPressed(0);
                }),
                SizedBox(height: 20),
                PickUserCard(title: "Estudiante", imagePath: 'assets/images/student_login_image.jpg', onPressed: (){
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