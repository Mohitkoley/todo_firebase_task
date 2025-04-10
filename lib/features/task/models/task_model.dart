class Task {
  String id;
  String title;
  String description;
  bool isCompleted;
  String ownerId;
  List<String> sharedWith;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.ownerId,
    required this.sharedWith,
  });

  factory Task.fromJson(Map<String, dynamic> json, String id) => Task(
    id: id,
    title: json['title'],
    description: json['description'],
    isCompleted: json['isCompleted'],
    ownerId: json['ownerId'],
    sharedWith: List<String>.from(json['sharedWith'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'ownerId': ownerId,
    'sharedWith': sharedWith,
  };
}
