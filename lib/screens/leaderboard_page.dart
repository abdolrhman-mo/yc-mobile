import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/leaderboard_service.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final LeaderBoardService _leaderboardService = LeaderBoardService();
  List<String> names = [];

  @override
  void initState() {
    super.initState();
    fetchNames();
  }

  Future<void> fetchNames() async {
    try {
      final fetchedNames = await _leaderboardService.fetchNames();
      setState(() {
        names = fetchedNames;
      });
    } catch (e) {
      // Handle errors appropriately here
      print('Error fetching names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: names.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(names[index]),
                );
              },
            ),
    );
  }
}
