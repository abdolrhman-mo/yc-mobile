import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/streak_service.dart';
import 'package:flutter_application_2/utils/timer_helper.dart';
import 'package:audioplayers/audioplayers.dart';

void showConfettiDialog(
    BuildContext context, Function onTakeBreak, Function onSkipBreak) {
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 10));
  confettiController.play();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.alarm, size: 50, color: Colors.black54),
                  SizedBox(height: 10),
                  Text(
                    "Time's up!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            child: const Text("Take a 10 mins break"),
            onPressed: () {
              confettiController.stop();
              Navigator.of(context).pop();
              onTakeBreak();
            },
          ),
          TextButton(
            child: const Text("Skip break"),
            onPressed: () {
              confettiController.stop();
              Navigator.of(context).pop();
              onSkipBreak();
            },
          ),
        ],
      );
    },
  );
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const int _25_MINUTES = 2;
  static const int _50_MINUTES = 50 * 60;
  static const int _10_MINUTES = 10 * 60;

  late TimerHelper _timerHelper;
  late StreakService _streakService;
  late AudioPlayer _audioPlayer;
  int _remainingTime = _25_MINUTES;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _streakService = StreakService();
    _timerHelper = TimerHelper(
      remainingTime: _remainingTime,
      onTimerEnd: _onTimerEnd,
      onTick: (time) {
        setState(() {
          _remainingTime = time;
        });
      },
    );
    _audioPlayer = AudioPlayer();
  }

  void _startTimer(int duration) {
    setState(() {
      _remainingTime = duration;
      _isRunning = true;
      _isPaused = false;
    });
    _timerHelper.remainingTime = duration;
    _timerHelper.start();
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
    _timerHelper.pause();
  }

  void _resumeTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    _timerHelper.resume();
  }

  Future<void> _onTimerEnd() async {
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });
    _playAlarm();
    showConfettiDialog(context, _takeBreak, _skipBreak);
    await _streakService.incrementStreak(_remainingTime ~/ 60);
  }

  void _takeBreak() {
    _stopAlarm();
    _startTimer(_10_MINUTES);
  }

  void _skipBreak() {
    _stopAlarm();
    setState(() {
      _remainingTime = _25_MINUTES;
      _isRunning = false;
      _isPaused = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _playAlarm() async {
    await _audioPlayer.play(AssetSource('sounds/ringtone.mp3'));
  }

  void _stopAlarm() {
    _audioPlayer.stop();
  }

  @override
  void dispose() {
    _timerHelper.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_remainingTime),
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? null : () => _startTimer(_25_MINUTES),
                  child: const Text('Start 25 mins'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? null : () => _startTimer(_50_MINUTES),
                  child: const Text('Start 50 mins'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _isRunning ? _pauseTimer : (_isPaused ? _resumeTimer : null),
              child: Text(_isRunning ? 'Pause' : 'Resume'),
            ),
          ],
        ),
      ),
    );
  }
}
