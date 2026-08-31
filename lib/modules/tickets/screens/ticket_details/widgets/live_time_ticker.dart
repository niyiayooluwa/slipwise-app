import 'dart:async';
import 'package:flutter/material.dart';

class MatchClockState {
  final bool isTicking;
  final int currentSeconds;
  final String displayText;

  MatchClockState({
    required this.isTicking,
    required this.currentSeconds,
    required this.displayText,
  });

  factory MatchClockState.fromServer({
    required String matchStatus,
    required String? liveTime,
  }) {
    // 1. Not live or null time
    if (matchStatus != 'LIVE' || liveTime == null || liveTime.trim().isEmpty) {
      return MatchClockState(
        isTicking: false,
        currentSeconds: 0,
        displayText: matchStatus == 'ENDED' ? 'FT' : '',
      );
    }

    final raw = liveTime.trim();

    // 2. Non-numeric status strings like HT / FT
    if (raw.toUpperCase().contains('HT') || raw.toUpperCase().contains('HALF')) {
      return MatchClockState(isTicking: false, currentSeconds: 45 * 60, displayText: 'HT');
    }
    if (raw.toUpperCase().contains('FT') || raw.toUpperCase().contains('END')) {
      return MatchClockState(isTicking: false, currentSeconds: 90 * 60, displayText: 'FT');
    }

    // 3. Normalize stoppage time (e.g. "45:00+2" or "90:00+")
    String cleanTime = raw.split('+').first.trim();

    // 4. Parse MM:SS or MM
    int totalSeconds = 0;
    if (cleanTime.contains(':')) {
      final parts = cleanTime.split(':');
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      totalSeconds = (minutes * 60) + seconds;
    } else {
      final minutes = int.tryParse(cleanTime) ?? 0;
      totalSeconds = minutes * 60;
    }

    return MatchClockState(
      isTicking: true,
      currentSeconds: totalSeconds,
      displayText: _formatSeconds(totalSeconds),
    );
  }

  static String _formatSeconds(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

class LiveTimeTicker extends StatefulWidget {
  final String matchStatus;
  final String? liveTime;
  final TextStyle? style;

  const LiveTimeTicker({
    super.key,
    required this.matchStatus,
    this.liveTime,
    this.style,
  });

  @override
  State<LiveTimeTicker> createState() => _LiveTimeTickerState();
}

class _LiveTimeTickerState extends State<LiveTimeTicker> {
  Timer? _timer;
  late MatchClockState _clockState;
  int _localSeconds = 0;

  @override
  void initState() {
    super.initState();
    _clockState = MatchClockState.fromServer(
      matchStatus: widget.matchStatus,
      liveTime: widget.liveTime,
    );
    _localSeconds = _clockState.currentSeconds;
    _startTicker();
  }

  @override
  void didUpdateWidget(covariant LiveTimeTicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Correct drift when Delta-Sync fetches fresh data
    if (widget.liveTime != oldWidget.liveTime || widget.matchStatus != oldWidget.matchStatus) {
      _clockState = MatchClockState.fromServer(
        matchStatus: widget.matchStatus,
        liveTime: widget.liveTime,
      );
      _localSeconds = _clockState.currentSeconds;
      _startTicker();
    }
  }

  void _startTicker() {
    _timer?.cancel();
    if (_clockState.isTicking) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {
            _localSeconds++;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    if (!_clockState.isTicking) return _clockState.displayText;
    return MatchClockState._formatSeconds(_localSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedTime,
      style: widget.style,
    );
  }
}
