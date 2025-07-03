import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final dio = Dio();

class EmpresaServices {
  static Future<List<Map<String, dynamic>>> getEmpresas() async {
    try {
      String? token = await UserServices.getToken();
      Response response = await dio.get(
        '${dotenv.env['API_DOMAIN']}/company',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger.d(response);
      List<Map<String, dynamic>> empresas = [];
      print(response.data);
      if (response.data is List) {
        for (var empresa in response.data) {
          Uint8List? foto;
          if (empresa['photo'] != null) {
            foto = Uint8List.fromList(
                (empresa['photo']['data'] as List<dynamic>).cast<int>());
          }
          empresas.add({
            'id': empresa['id'],
            'nombre': empresa['name'],
            'address': empresa['address'],
            'descripcion': empresa['description'],
            'website': empresa['website'],
            'location': empresa['location'],
            'foto': foto,
          });
        }
      }
      return empresas;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> registerEmpresa(body, File? photo) async {
    try {
      final name = body['name'];
      final address = body['address'];
      final description = body['description'];
      final website = body['website'];
      final location = body['location'];
      final color = body['color'];
      String? token = await UserServices.getToken();
      logger.e('Aasdfsdf $photo');
      Response response = await dio.post(
        '${dotenv.env['API_DOMAIN']}/company',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          },
        ),
        data: FormData.fromMap({
          'name': name,
          'address': address,
          'description': description,
          'website': website,
          'location': location,
          'color': color,
          'photo': photo != null
              ? await MultipartFile.fromFile(photo.path,
                  filename: photo.path.split('/').last)
              : null,
          // Add other fields as required
        }),
      );
      logger.e("$response");
      return response.data;
    } /*  on DioException {
      logger.e('dio exception');
      rethrow;
    }  */
    catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<dynamic> deleteEmpresa(int id) async {
    try {
      String? token = await UserServices.getToken();
      Response response = await dio.delete(
        '${dotenv.env['API_DOMAIN']}/company/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger.d(response);
    } on DioException catch (error) {
      final response = error.response;
      logger.e(response?.data['message']);
      if (response?.statusCode == 400 && response?.data['message'] != 500) {
        throw 'No se puede eliminar la empresa';
      } else {
        throw response?.data['message'];
      }
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
