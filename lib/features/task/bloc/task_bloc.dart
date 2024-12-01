// task_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:re_task/features/task/data/task_repository.dart';
import 'package:re_task/models/task_data.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    // Registrasikan event handler
    on<FetchTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        // Mendengarkan data task secara real-time
        await emit.forEach<List<TaskData>>(
          taskRepository.getTasks(), // Mendapatkan stream tasks
          onData: (tasks) => TaskLoaded(tasks),
          onError: (error, stackTrace) =>
              TaskError("Error fetching tasks: $error"),
        );
      } catch (e) {
        emit(TaskError("Error fetching tasks: $e"));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await taskRepository.addTask(event.task);
      } catch (e) {
        emit(TaskError("Error adding task: $e"));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await taskRepository.deleteTask(event.taskId);
      } catch (e) {
        emit(TaskError("Error deleting task: $e"));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await taskRepository.updateTask(event.task);
      } catch (e) {
        emit(TaskError("Error updating task: $e"));
      }
    });
  }
}
