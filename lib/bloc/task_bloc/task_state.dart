part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}
// class TaskInitial extends TaskState {}

class TaskAdded extends TaskState {
  TaskAdded();

  @override
  List<Object> get props => [];
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});

  @override
  List<Object> get props => [message];
}
