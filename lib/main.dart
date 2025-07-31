import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/alarm_provider.dart';
import 'screens/home_screen.dart';
import 'services/alarm_scheduler.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AlarmProvider(),
      child: const FreshAlarmApp(),
    ),
  );
}

class FreshAlarmApp extends StatefulWidget {
  const FreshAlarmApp({super.key});

  @override
  State<FreshAlarmApp> createState() => _FreshAlarmAppState();
}

class _FreshAlarmAppState extends State<FreshAlarmApp> {
  final _scheduler = AlarmScheduler();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scheduler.start(context); // Start checking alarms
  }

  @override
  void dispose() {
    _scheduler.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Alarm',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}
