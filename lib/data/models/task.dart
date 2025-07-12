class Task {
  final int idTask;
  final String taskName;
  final String taskDesc;
  final String taskCategory;
  final String taskFrequently;
  final String taskVidioUrl;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final int userId;

  Task({
    required this.idTask,
    required this.taskName,
    required this.taskDesc,
    required this.taskCategory,
    required this.taskFrequently,
    required this.taskVidioUrl,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      idTask: json['id_task'],
      taskName: json['task_name'],
      taskDesc: json['task_desc'],
      taskCategory: json['task_category'],
      taskFrequently: json['task_frequntly'],
      taskVidioUrl: json['task_vidio_url'],
      createdAt: DateTime.parse(json['created_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_task': idTask,
      'task_name': taskName,
      'task_desc': taskDesc,
      'task_category': taskCategory,
      'task_frequntly': taskFrequently,
      'task_vidio_url': taskVidioUrl,
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
    };
  }
}
