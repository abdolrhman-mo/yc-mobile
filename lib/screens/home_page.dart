import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/leaderboard_page.dart';
import 'package:flutter_application_2/screens/profile_page.dart';
import 'package:flutter_application_2/screens/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            TimerPage(),
            LeaderboardPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.timer), text: 'Timer'),
          Tab(icon: Icon(Icons.leaderboard), text: 'Leaderboard'),
          Tab(icon: Icon(Icons.person), text: 'Profile'),
        ],
        labelColor: Colors.black,
        unselectedLabelColor: const Color.fromARGB(255, 62, 62, 62),
        indicatorColor: Colors.transparent,
      ),
    );
  }
}
