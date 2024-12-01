import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_task/models/statistic_model.dart';

class StatisticsRepository {
  final FirebaseFirestore firestore;

  StatisticsRepository({required this.firestore});

  Future<TaskStatusStatistics> fetchStatistics() async {
    final snapshot = await firestore.collection('task').get();
    int completed = 0;
    int pending = 0;
    int inProgress = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final status = data['status'] ?? '';
      if (status == 'completed') {
        completed++;
      } else if (status == 'pending') {
        pending++;
      } else if (status == 'in-progress') {
        inProgress++;
      }
    }

    return TaskStatusStatistics(
      completed: completed,
      pending: pending,
      inProgress: inProgress,
    );
  }
}
