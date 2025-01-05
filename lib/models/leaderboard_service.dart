import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderBoardService {
  Future<List<String>> fetchNames() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((user) => user['name'] as String).toList();
    } else {
      throw Exception('Failed to load names');
    }
  }
}
