import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';
import 'dart:typed_data';

class EstudiantesServices {
  static Future<List<Map<String, dynamic>>> getEstudiantes() async {
    try {
      String? token = UserServices.getToken();
      Response response = await dio.get(
        'http://10.0.2.2:3000/student',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger.d(response);
      List<Map<String, dynamic>> estudiantes = [];
      for (var estudiante in response.data) {
        Uint8List? foto;
        if (estudiante['userProfile'] != null && estudiante['userProfile']['photo'] != null) {
          foto = Uint8List.fromList((estudiante['userProfile']['photo']['data'] as List<dynamic>).cast<int>());
        }
        estudiantes.add({
          'nombre': estudiante['userProfile'] != null
              ? "${estudiante['userProfile']['first_name']} ${estudiante['userProfile']['last_name']}"
              : "No disponible",
          'foto': foto ?? 'assets/profile_picture.jpg',
          'descripcion': estudiante['description'],
        });
      }
      return estudiantes;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
