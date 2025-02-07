import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final dio = Dio();

class UserServices {
  static Future<List<Map<String, String>>> getEstudiantes() async {
    try {
      String? token = getToken();
      Response response = await dio.get(
        'http://localhost:3000/student',
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

  static Future<Map<String, String>> login(
      String email, String password) async {
    try {
      Response response = await dio.post(
        'http://localhost:3000/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return {
        'token': response.data['token'],
      };
    } catch (e) {
      logger.e(e);
      return {};
    }
  }

  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static String? getToken() {
    return _token;
  }
}
