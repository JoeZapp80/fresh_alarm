class Alarm {
  final String time;
  final String label;

  Alarm({required this.time, required this.label});

  Map<String, dynamic> toJson() => {
    'time': time,
    'label': label,
  };

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    time: json['time'],
    label: json['label'],
  );
}
