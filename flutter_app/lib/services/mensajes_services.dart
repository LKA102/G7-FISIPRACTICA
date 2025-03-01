import 'package:dio/dio.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final dio = Dio();

class MensajesServices {
  static Future<List<Map<String, dynamic>>> getMensajes(int chatId) async {
    try {
      String? token = await UserServices.getToken();
      var user = await UserServices.getUser();
      Response response = await dio.get(
        '${dotenv.env['API_DOMAIN']}/message/$chatId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger.d(response);
      List<Map<String, dynamic>> mensajes = [];
      if (response.data is List) {
        for (var mensaje in response.data) {
          mensajes.add({
            'id': mensaje['id'],
            'mensaje': mensaje['message'],
            'is_me': mensaje['user_id'] == user['sub'],
            'user_id': mensaje['user_id'],
            'fecha': mensaje['create_date'],
            'estudiante_id':
                mensaje['chat'] != null ? mensaje['chat']['student_id'] : null,
            'reclutador_id': mensaje['chat'] != null
                ? mensaje['chat']['recruiter_id']
                : null,
            'job_id':
                mensaje['chat'] != null ? mensaje['chat']['job_id'] : null,
          });
        }
      }
      return mensajes;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
