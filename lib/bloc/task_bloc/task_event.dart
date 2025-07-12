part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskAdd extends TaskEvent {
  final String taskName;
  final String desc;
  final String age;
  final String frequently;
  final String videoURL;

  TaskAdd({
    required this.taskName,
    required this.desc,
    required this.age,
    required this.frequently,
    required this.videoURL,
  });

  @override
  List<Object> get props => [taskName, desc, age, frequently, videoURL];
}
