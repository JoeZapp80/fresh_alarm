import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alarm.dart';

class AlarmProvider extends ChangeNotifier {
  List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  AlarmProvider() {
    loadAlarms();
  }

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    saveAlarms();
    notifyListeners();
  }

  void removeAlarm(int index) {
    _alarms.removeAt(index);
    saveAlarms();
    notifyListeners();
  }

  void saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _alarms.map((a) => json.encode(a.toJson())).toList();
    await prefs.setStringList('alarms', data);
  }

  void loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('alarms') ?? [];
    _alarms = data.map((s) => Alarm.fromJson(json.decode(s))).toList();
    notifyListeners();
  }
}
