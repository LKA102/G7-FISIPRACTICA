import 'package:dio/dio.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final logger = Logger();

final dio = Dio();

class UserServices {
  static Future<Map<String, String>> login(
      String email, String password, String role) async {
    try {
      Response response = await dio.post(
        '${dotenv.env['API_DOMAIN']}/auth/login',
        data: {
          'email': email,
          'password': password,
          'role': role,
        },
      );
      await SessionManager().set('token', response.data['access_token']);
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

  static Future<String?> getToken() async {
    return await SessionManager().get('token');
  }

  static void setUser() async {
    try {
      final user = JwtDecoder.decode(_token!);
      await SessionManager().set('user', user);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getUser() async {
    try {
      final token = await SessionManager().get('token');
      final user = JwtDecoder.decode(token);
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
