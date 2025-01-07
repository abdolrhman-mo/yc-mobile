import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderBoardService {
  Future<List<String>> fetchFollowings() async {
    // final response =
    //     await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   return data.map((user) => user['name'] as String).toList();
    // } else {
    //   throw Exception('Failed to load names');
    // }
    return ['Ahmed', 'Mohamed', 'Ali', 'Omar', 'Khaled'];
  }

  Future<List<String>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((user) => user['name'] as String).toList();
    } else {
      throw Exception('Failed to load names');
    }
  }

  Future<void> followUser(String userId) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$userId/follow'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }
  }
}
