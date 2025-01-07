import 'dart:async';

class TimerHelper {
  int remainingTime;
  final void Function() onTimerEnd;
  final void Function(int) onTick;
  Timer? _timer;

  TimerHelper({
    required this.remainingTime,
    required this.onTimerEnd,
    required this.onTick,
  });

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        onTick(remainingTime);
      } else {
        stop();
        onTimerEnd();
      }
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void resume() {
    start();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
