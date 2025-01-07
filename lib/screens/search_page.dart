import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/leaderboard_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final LeaderBoardService _leaderboardService = LeaderBoardService();
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  List<String> _allUsers = [];
  Set<String> _followedUsers = {};

  @override
  void initState() {
    super.initState();
    fetchUsers('');
  }

  Future<void> fetchUsers(String query) async {
    try {
      final fetchedFollowings = await _leaderboardService.fetchUsers();
      setState(() {
        _allUsers = fetchedFollowings;
        _searchResults = _allUsers
            .where((user) => user.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } catch (e) {
      print('Error fetching names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for friends',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                fetchUsers(query);
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index];
                  final isFollowed = _followedUsers.contains(user);
                  return ListTile(
                    title: Text(user),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        try {
                          // await _leaderboardService.followUser(user);
                          setState(() {
                            _followedUsers.add(user);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Followed $user')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to follow $user')),
                          );
                        }
                      },
                      child: Text(isFollowed ? 'Following' : 'Follow'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
