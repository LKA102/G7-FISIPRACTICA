import 'package:dio/dio.dart';

final dio = Dio();

class UserServices {
  static Future<List<Map<String, String>>> getEstudiantes() async {
    try {
      Response response = await dio.get(
        'http://localhost:3000/student',
        options: Options(
          headers: {
            'Authorization':
                'Bearer {}',
          },
        ),
      );
      List<Map<String, String>> estudiantes = [];
      print(response);
      for (var estudiante in response.data) {
        estudiantes.add({
          'nombre': estudiante['code'],
          'foto': 'assets/profile_picture.jpg',
          'descripcion': 'Descripción de ${estudiante['code']}',
        });
      }

      return estudiantes;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
