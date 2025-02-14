import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

final logger = Logger();
final dio = Dio();

class ReclutadoresServices {
  static Future<List<Map<String, String>>> getReclutadores() async {
    try {
      String? token = UserServices.getToken();
      Response response = await dio.get(
        '${dotenv.env['API_DOMAIN']}/recruiter',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger.d(response);
      List<Map<String, String>> reclutadores = [];
      for (var reclutador in response.data) {
        reclutadores.add({
          'nombre': reclutador['name'],
          'foto': 'assets/profile_picture.jpg',
          'descripcion': 'Descripción de ${reclutador['name']}',
        });
      }
      return reclutadores;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
