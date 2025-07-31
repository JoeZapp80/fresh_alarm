import 'package:flutter/material.dart';
import '../models/alarm.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onDelete;

  const AlarmTile({super.key, required this.alarm, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(alarm.time, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(alarm.label),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
