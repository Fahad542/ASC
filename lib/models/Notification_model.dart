

class Notification_model {
  String? title;
  String? body;
  DateTime? timestamp;

  Notification_model({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory Notification_model.fromJson(Map<String, dynamic> json) {
    return Notification_model(
      title: json['title'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']), // Parse the DateTime from a string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp?.toIso8601String(), // Convert DateTime to a string
    };
  }
}
