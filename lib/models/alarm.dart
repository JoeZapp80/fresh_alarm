class Alarm {
  final DateTime time;
  final String label;
  final String soundPath;  // can be asset name OR file path

  Alarm({
    required this.time,
    required this.label,
    this.soundPath = 'birds.wav',  // default sound
  });

  Map<String, dynamic> toJson() => {
    'time': time.toIso8601String(),
    'label': label,
    'soundPath': soundPath,
  };

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    time: DateTime.parse(json['time']),
    label: json['label'],
    soundPath: json['soundPath'] ?? 'birds.wav',
  );
}
