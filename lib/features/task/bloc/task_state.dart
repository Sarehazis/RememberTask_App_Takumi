part of 'task_bloc.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskData> tasks;

  TaskLoaded(this.tasks);

  // Menambahkan fungsi untuk memperbarui task
  TaskLoaded updateTask(TaskData updatedTask) {
    List<TaskData> updatedTasks = List.from(tasks);
    final index = updatedTasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      updatedTasks[index] = updatedTask; // Update task pada index yang sesuai
    }
    return TaskLoaded(updatedTasks);
  }
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
