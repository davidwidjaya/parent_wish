import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/data/repositories/repository_manager.dart';
import 'package:parent_wish/data/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository = RepositoryManager.taskRepository;

  TaskBloc() : super(TaskInitial()) {
    on<TaskAdd>((event, emit) async {
      emit(TaskLoading());
      try {
        final result = await taskRepository.addTask(
          name: event.taskName,
          description: event.desc,
          age: event.age,
          frequently: event.frequently,
          videoURL: event.videoURL,
        );

        emit(TaskAdded());
      } catch (error) {
        emit(TaskError(message: error.toString()));
      }
    });
  }
}
