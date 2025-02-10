import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../../../../widgets/header.dart';
import 'widgets/login_form.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Header(showLoginDialog: true),
          SizedBox(height: 20),
          const LoginForm(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}