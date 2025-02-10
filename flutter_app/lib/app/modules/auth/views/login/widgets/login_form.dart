import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_app/app/routes/routes.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<AuthController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/logo_azul.png',
              height: 208,
              width: 211,
            ),
            TextFormField(
              controller: controller.loginEmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: pepito@unmsm.edu.pe',
                label: Text("Correo electrónico")
              )
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.loginPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: 123456',
                label: Text("Contraseña")
              )
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                      onPressed: () {
                        controller.submit();
                        //TODO: Redirect to the right homepage screen (student or recruiter)
                        Get.toNamed(AppRoutes.getAdminHomePage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E3984),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.black.withAlpha(128),
                        elevation: 10,
                      ),
                      child: Text('Iniciar sesión'),
                    ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Aun no eres usuario?', style: TextStyle(fontSize: 14)),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    // );
                  },
                  child: const Text(
                    'Registrate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                // );
              },
              child: const Text('Olvidaste tu contraseña?'),
            ),
          ]
        )
      )
    );
  }
}