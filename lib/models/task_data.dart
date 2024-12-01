class TaskData {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskData({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory TaskData.fromMap(String id, Map<String, dynamic> map) {
    return TaskData(
      id: id,
      title: map['title'],
      description: map['description'],
      status: map['status'] ?? 'Pending',
      priority: map['priority'] ?? 'Low',
      dueDate: DateTime.parse(map['dueDate']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
