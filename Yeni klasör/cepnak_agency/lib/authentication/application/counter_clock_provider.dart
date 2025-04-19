import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterClockProvider =
    StateNotifierProvider.family<CounterClock, int, int>((ref, duration) {
  return CounterClock(duration);
});

class CounterClock extends StateNotifier<int> {
  final int duration;
  // 1. initialize with current time
  CounterClock(this.duration) : super(duration) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // 3. update the state with the current time
      state = state > 0 ? state - 1 : 0;
    });
  }

  late final Timer _timer;

  void resend() {
    state = duration;
  }

  // 4. cancel the timer when finished
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
