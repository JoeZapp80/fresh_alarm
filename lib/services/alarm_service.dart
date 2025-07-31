import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../models/alarm.dart';

Future<void> playAlarmSound(Alarm alarm) async {
  final player = AudioPlayer();

  try {
    if (alarm.soundPath.toLowerCase().endsWith('.mp3') ||
        alarm.soundPath.toLowerCase().endsWith('.wav')) {
      if (alarm.soundPath.contains('/')) {
        // Likely a custom file path
        await player.play(DeviceFileSource(alarm.soundPath));
      } else {
        // Likely an asset
        await player.play(AssetSource('assets/sounds/${alarm.soundPath}'));
      }
    } else {
      // Fallback/default
      await player.play(AssetSource('assets/sounds/default.mp3'));
    }
  } catch (e) {
    if (kDebugMode) {
      print('Failed to play alarm sound: $e');
    }
  }
}
