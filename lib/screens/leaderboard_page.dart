import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/search_page.dart';
import 'package:flutter_application_2/services/leaderboard_service.dart';

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
    fetchFollowings();
  }

  Future<void> fetchFollowings() async {
    try {
      final fetchedFollowings = await _leaderboardService.fetchFollowings();
      setState(() {
        names = fetchedFollowings;
      });
    } catch (e) {
      print('Error fetching names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the search page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Search for a Friend'),
              ),
            ),
          ),
          Expanded(
            child: names.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: names.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(names[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
