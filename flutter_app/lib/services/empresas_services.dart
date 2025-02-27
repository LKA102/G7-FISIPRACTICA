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
          empresas.add({
            'id': empresa['id'],
            'nombre': empresa['name'],
            'address': empresa['address'],
            'descripcion': empresa['description'],
            'website': empresa['website'],
            'location': empresa['location'],
          });
        }
      }
      return empresas;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
