class TaskManager {
  final int id;
  final String title;
  final String description;
  bool completed;

  TaskManager({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory TaskManager.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>?;

    return TaskManager(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      title: attributes?['Title'],
      description: attributes?['Description'],
      completed: attributes?['Completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': {
        'Title': title,
        'Description': description,
        'Completed': completed,
      },
    };
  }
}
