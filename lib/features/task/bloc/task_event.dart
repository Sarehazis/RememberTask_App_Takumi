part of 'task_bloc.dart';

abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskData task;

  AddTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskData task;

  UpdateTaskEvent(this.task);
}
