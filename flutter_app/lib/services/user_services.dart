import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final dio = Dio();

class UserServices {
  static Future<Map<String, String>> login(
      String email, String password, String role) async {
    try {
      Response response = await dio.post(
        'http://10.0.2.2:3000/auth/login',
        data: {
          'email': email,
          'password': password,
          'role': role,
        },
      );

      return {
        'token': response.data['access_token'],
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
