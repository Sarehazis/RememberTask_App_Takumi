import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  // Daftar pesan forum
  final List<Map<String, String>> _messages = [
    {
      'sender': 'John Doe',
      'message': 'Hi everyone! Let’s discuss the new project updates.',
      'timestamp': '2 hours ago'
    },
    {
      'sender': 'Jane Smith',
      'message': 'Does anyone have resources for the task module?',
      'timestamp': '3 hours ago'
    },
    {
      'sender': 'Michael Lee',
      'message': 'Reminder: Meeting is scheduled for tomorrow at 10 AM.',
      'timestamp': '5 hours ago'
    },
    {
      'sender': 'Emily Davis',
      'message': 'I have shared the document in the group drive.',
      'timestamp': '1 day ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Messages',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            onPressed: _addMessage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];
            return _buildMessageCard(
              sender: message['sender']!,
              message: message['message']!,
              timestamp: message['timestamp']!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageCard({
    required String sender,
    required String message,
    required String timestamp,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(sender[0],
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        title:
            Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }

  // Fungsi untuk menambahkan pesan baru
  void _addMessage() {
    setState(() {
      _messages.add({
        'sender': 'New User',
        'message': 'This is a new message.',
        'timestamp': 'Just now',
      });
    });
  }
}
