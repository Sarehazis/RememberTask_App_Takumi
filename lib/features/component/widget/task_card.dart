import 'package:flutter/material.dart';
import 'package:re_task/models/task_data.dart';

class TaskCard extends StatefulWidget {
  final TaskData task;

  const TaskCard({super.key, required this.task});

  @override
  // ignore: library_private_types_in_public_api
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task; // Mengambil task dari widget
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          _getIconForPriority(task.priority),
          color: _getColorForPriority(task.priority),
        ),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            Text(
              'Status: ${task.status}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getStatusColor(task.status),
              ),
            ),
            Text(
              'Due Date: ${task.dueDate.toLocal().toString().split(' ')[0]}',
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Priority: ${task.priority}'),
            Text(
                'Created: ${task.createdAt.toLocal().toString().split(' ')[0]}'),
          ],
        ),
      ),
    );
  }

  IconData _getIconForPriority(String priority) {
    switch (priority) {
      case 'High':
        return Icons.priority_high;
      case 'Medium':
        return Icons.access_alarm;
      case 'Low':
        return Icons.low_priority;
      default:
        return Icons.priority_high;
    }
  }

  Color _getColorForPriority(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.grey;
      case 'In-Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
