import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alarm_provider.dart';
import '../models/alarm.dart';
import '../widgets/alarm_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Fresh Alarm')),
      body: ListView.builder(
        itemCount: alarmProvider.alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarmProvider.alarms[index];
          return AlarmTile(
            alarm: alarm,
            onDelete: () => alarmProvider.removeAlarm(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAlarmDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddAlarmDialog(BuildContext context) {
    final timeController = TextEditingController();
    final labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Alarm'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: 'Time (e.g., 07:30 AM)'),
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (timeController.text.isNotEmpty && labelController.text.isNotEmpty) {
                final newAlarm = Alarm(
                  time: timeController.text,
                  label: labelController.text,
                );
                Provider.of<AlarmProvider>(context, listen: false).addAlarm(newAlarm);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
