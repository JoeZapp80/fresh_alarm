import 'package:permission_handler/permission_handler.dart';

Future<void> requestAudioPermission() async {
  var status = await Permission.audio.status;

  if (!status.isGranted) {
    status = await Permission.audio.request();
  }

  if (!status.isGranted) {
    throw Exception('Permission to access audio files was denied.');
  }
}
