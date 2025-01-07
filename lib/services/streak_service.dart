import 'dart:convert';
import 'package:http/http.dart' as http;

class StreakService {
  final String _baseUrl = 'https://blnose2.pythonanywhere.com/api';

  Future<void> startStreak(Map<String, dynamic> requestBody) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/streak/start'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Streak started successfully');
    } else {
      // Handle error response
      print('Failed to start streak: ${response.statusCode}');
    }
  }

  Future<void> incrementStreak(int durationMinutes) async {
    final url = Uri.parse('$_baseUrl/streak/increment');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'duration': durationMinutes}),
    );

    if (response.statusCode == 200) {
      print('Streak incremented successfully!');
    } else {
      print('Failed to increment streak: ${response.body}');
    }
  }
}
