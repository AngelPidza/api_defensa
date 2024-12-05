import 'package:api_defensa/models/classroom.dart';
import 'package:flutter/material.dart';

class ClassroomCard extends StatelessWidget {
  final Classroom classroom;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ClassroomCard({
    super.key,
    required this.classroom,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(classroom.title),
        subtitle: Text('ID: ${classroom.id}'),
        children: [
          ListTile(
            title: Text('Niños'),
            subtitle: Text(classroom.childs.join(', ')),
          ),
          ListTile(
            title: Text('Lecciones'),
            subtitle: Text(classroom.lessons.join(', ')),
          ),
          ButtonBar(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
