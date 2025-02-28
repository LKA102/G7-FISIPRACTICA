import 'dart:typed_data';

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

  static Future<List<Map<String, dynamic>>> getReclutadores() async {
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
      List<Map<String, dynamic>> reclutadores = [];
      for (var reclutador in response.data) {
        Uint8List? foto;
        if (reclutador['userProfile'] != null &&
            reclutador['userProfile']['photo'] != null) {
          foto = Uint8List.fromList(
              (reclutador['userProfile']['photo']['data'] as List<dynamic>)
                  .cast<int>());
        }
        reclutadores.add({
          'nombre': reclutador['userProfile'] != null
              ? reclutador['userProfile']['first_name']
              : "No disponible",
          'apellido': reclutador['userProfile'] != null
              ? reclutador['userProfile']['last_name']
              : "No disponible",
          'correo': reclutador['userProfile'] != null
              ? reclutador['userProfile']['email']
              : "No disponible",
          'descripcion': reclutador['description'] ?? "No disponible",
          'fecha_inicio': reclutador['position_start_date'] != null
              ? '${DateTime.parse(reclutador['position_start_date']).day.toString().padLeft(2, '0')}/${DateTime.parse(reclutador['position_start_date']).month.toString().padLeft(2, '0')}/${DateTime.parse(reclutador['position_start_date']).year}'
              : "No disponible",
          'foto': foto,
          'empresa': reclutador['company']['name'],
          'color': reclutador['company']['color'],
        });
      }
      return reclutadores;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
