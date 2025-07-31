import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alarm_provider.dart';
import '../models/alarm.dart';
import 'alarm_service.dart';

class AlarmScheduler {
  Timer? _timer;
  final Set<String> _triggeredAlarms = {}; // avoid repeat plays per minute

  void start(BuildContext context) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 15), (_) async {
      final now = DateTime.now();
      final alarms = Provider.of<AlarmProvider>(context, listen: false).alarms;

      for (final alarm in alarms) {
        final alarmKey = "${alarm.time.hour}:${alarm.time.minute} - ${alarm.label}";

        if (_isSameMinute(now, alarm.time) && !_triggeredAlarms.contains(alarmKey)) {
          await playAlarmSound(alarm);
          _triggeredAlarms.add(alarmKey);
        }
      }

      // Clear triggers every minute
      _triggeredAlarms.removeWhere((key) => !key.contains("${now.hour}:${now.minute}"));
    });
  }

  bool _isSameMinute(DateTime now, DateTime alarmTime) {
    return now.hour == alarmTime.hour && now.minute == alarmTime.minute;
  }

  void stop() {
    _timer?.cancel();
  }
}
