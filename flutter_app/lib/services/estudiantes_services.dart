import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';

class EstudiantesServices {
  static Future<List<Map<String, String>>> getEstudiantes() async {
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
      List<Map<String, String>> estudiantes = [];
      for (var estudiante in response.data) {
        estudiantes.add({
          'nombre': estudiante['code'],
          'foto': 'assets/profile_picture.jpg',
          'descripcion': 'Descripción de ${estudiante['code']}',
        });
      }
      return estudiantes;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
