import 'dart:async';
import 'package:flutter/material.dart';

class HomeFocusMode extends StatefulWidget {
  const HomeFocusMode({super.key});
  @override
  State<HomeFocusMode> createState() => _HomeFocusModeState();
}

class _HomeFocusModeState extends State<HomeFocusMode> {
  static const int workDuration = 25 * 60;
  int _seconds = workDuration;
  bool _isRunning = false;
  Timer? _timer;

  void _toggleTimer() {
    setState(() => _isRunning = !_isRunning);
    if (_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds > 0) {
          setState(() => _seconds--);
        } else {
          _timer?.cancel();
          _isRunning = false;
          _seconds = workDuration;
        }
      });
    } else {
      _timer?.cancel();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = workDuration;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = 1 - (_seconds / workDuration);

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("FOCUS MODE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      Text(
                        "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                ),
                GestureDetector(
                  onTap: _toggleTimer,
                  child: Icon(_isRunning ? Icons.pause_circle : Icons.play_circle, size: 45, color: theme.colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colorScheme.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}