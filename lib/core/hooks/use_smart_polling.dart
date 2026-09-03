import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A smart polling hook that implements:
/// 1. Foreground Only: Pauses when the app is minimized.
/// 2. Adaptive Polling (Exponential Backoff): Slows down if no data is returned.
/// 3. Conditional Polling: Suspends polling entirely when shouldPoll is false.
void useSmartPolling({
  required Future<bool> Function() fetchUpdates,
  bool shouldPoll = true,
}) {
  final appLifecycleState = useAppLifecycleState();
  final timerRef = useRef<Timer?>(null);
  final emptyResponsesCount = useRef<int>(0);
  final fetchUpdatesRef = useRef(fetchUpdates);

  // Always keep the latest callback
  fetchUpdatesRef.value = fetchUpdates;

  void scheduleNextPoll() {
    timerRef.value?.cancel();

    // Conditional Polling check
    if (!shouldPoll) {
      return;
    }

    // Foreground check: Don't schedule if app is not resumed
    // Using WidgetsBinding to always get the freshest state in async callbacks
    final currentState = WidgetsBinding.instance.lifecycleState;
    if (currentState != null && currentState != AppLifecycleState.resumed) {
      return;
    }

    // Exponential Backoff calculation
    int delaySeconds = 10;
    if (emptyResponsesCount.value == 1) {
      delaySeconds = 20;
    } else if (emptyResponsesCount.value >= 2) {
      delaySeconds = 60;
    }

    timerRef.value = Timer(Duration(seconds: delaySeconds), () async {
      // Execute the poll
      final hasData = await fetchUpdatesRef.value();

      if (hasData) {
        // Reset backoff on success
        emptyResponsesCount.value = 0;
      } else {
        // Increment backoff on empty response
        emptyResponsesCount.value++;
      }

      // Schedule next poll recursively
      scheduleNextPoll();
    });
  }

  useEffect(() {
    // Reset backoff when the app comes back to the foreground
    if (appLifecycleState == AppLifecycleState.resumed) {
      emptyResponsesCount.value = 0;
    }

    // Start or restart polling when lifecycle changes or conditional flag changes
    scheduleNextPoll();

    return () {
      timerRef.value?.cancel();
    };
  }, [appLifecycleState, shouldPoll]);
}
