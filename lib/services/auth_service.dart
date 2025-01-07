import 'dart:convert';
import 'package:flutter_application_2/services/streak_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'https://blnose2.pythonanywhere.com/api/auth';

  Future<bool> signUp(String username, String password) async {
    final url = Uri.parse('$_baseUrl/register/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({'username': username, 'password': password}),
      body: jsonEncode({'username': 'makady', 'password': '6IMn@Xxc'}),
    );

    // if (response.statusCode == 200) {
    //   final streaksService = StreakService();
    //   await streaksService.startStreak({'username': username});
    // }

    return response.statusCode == 200;
  }

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    return response.statusCode == 200;
  }
}
