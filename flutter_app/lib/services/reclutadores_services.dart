import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

final logger = Logger();
final dio = Dio();

class ReclutadoresServices {
  static Future<Map<String, dynamic>> registerReclutador(body) async {
    try {
      logger.d(body);
      final firstName = body['nombres'];
      final lastName = body['apellidos'];
      final email = body['email'];
      final password = body['password'];
      final companyId = body['empresa'];
      final description = body['descripcion'];
      final fechaInicio = body['fecha_inicio'];
      String? token = await UserServices.getToken();
      Response response = await dio.post(
        '${dotenv.env['API_DOMAIN']}/recruiter',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          },
        ),
        data: FormData.fromMap({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'company_id': companyId,
          'description': description,
          'position_start_date': fechaInicio,
          // Add other fields as required
        }),
      );
      return response.data;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
  static Future<List<Map<String, String>>> getReclutadores() async {
    try {
      String? token = await UserServices.getToken();
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
