import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onDelete;

  const AlarmTile({super.key, required this.alarm, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.jm().format(alarm.time);

    return ListTile(
      // Inside AlarmTile widget:
      onTap: () async {
        await playAlarmSound(alarm);
      },

      title: Text(
        formattedTime,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(alarm.label),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
