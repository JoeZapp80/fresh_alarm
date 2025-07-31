import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alarm_provider.dart';
import '../models/alarm.dart';
import 'package:file_picker/file_picker.dart';


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
          // Your AlarmTile code here (omitted for brevity)
          return ListTile(
            title: Text(alarm.label),
            subtitle: Text(alarm.time.toString()), // format as you want
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => alarmProvider.removeAlarm(index),
            ),
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
    TimeOfDay? pickedTime;
    final labelController = TextEditingController();

    String? selectedSoundPath; // holds custom file path
    String selectedPredefinedSound = Provider.of<AlarmProvider>(context, listen: false).predefinedSounds.first;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Alarm'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          pickedTime = time;
                        });
                      }
                    },
                    child: Text(
                      pickedTime == null ? 'Pick Time' : pickedTime!.format(context),
                    ),
                  ),
                  TextField(
                    controller: labelController,
                    decoration: const InputDecoration(labelText: 'Label'),
                  ),

                  const SizedBox(height: 12),

                  // Dropdown for predefined sounds
                  DropdownButton<String>(
                    value: selectedSoundPath == null ? selectedPredefinedSound : null,
                    hint: selectedSoundPath != null
                        ? Text(selectedSoundPath!.split('/').last) // show filename if custom chosen
                        : null,
                    items: Provider.of<AlarmProvider>(context, listen: false)
                        .predefinedSounds
                        .map((sound) => DropdownMenuItem(
                      value: sound,
                      child: Text(sound),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPredefinedSound = value!;
                        selectedSoundPath = null; // reset custom file if predefined selected
                      });
                    },
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['mp3', 'wav'],
                      );
                      if (result != null && result.files.single.path != null) {
                        setState(() {
                          selectedSoundPath = result.files.single.path!;
                        });
                      }
                    },
                    child: const Text('Browse Sound'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (pickedTime != null && labelController.text.trim().isNotEmpty) {
                      final now = DateTime.now();
                      final alarmDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        pickedTime!.hour,
                        pickedTime!.minute,
                      );

                      final newAlarm = Alarm(
                        time: alarmDateTime,
                        label: labelController.text.trim(),
                        soundPath: selectedSoundPath ?? selectedPredefinedSound,
                      );

                      Provider.of<AlarmProvider>(context, listen: false).addAlarm(newAlarm);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                )
              ],
            );
          },
        );
      },
    );
  }

}
