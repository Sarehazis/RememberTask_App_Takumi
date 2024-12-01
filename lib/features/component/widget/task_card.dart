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
    final task = widget.task;
    return Card(
      elevation: 4, // Memberikan efek bayangan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Membuat sudut membulat
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Memberikan padding internal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ikon prioritas
                CircleAvatar(
                  radius: 24,
                  backgroundColor: _getColorForPriority(task.priority)
                      .withOpacity(0.2), // Warna latar belakang transparan
                  child: Icon(
                    _getIconForPriority(task.priority),
                    color: _getColorForPriority(task.priority),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                // Informasi judul dan tanggal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status
                Chip(
                  label: Text(
                    task.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor:
                      _getStatusColor(task.status).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _getStatusColor(task.status),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Deskripsi tugas
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Memotong jika terlalu panjang
            ),
            const SizedBox(height: 8),
            // Informasi tambahan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Priority: ${task.priority}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Created: ${task.createdAt.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
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
