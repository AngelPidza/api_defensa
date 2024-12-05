import 'package:api_defensa/api_bloc/api_bloc/api_bloc.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/models/classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomDialog extends StatefulWidget {
  final Classroom? classroom;

  const ClassroomDialog({Key? key, this.classroom}) : super(key: key);

  @override
  State<ClassroomDialog> createState() => _ClassroomDialogState();
}

class _ClassroomDialogState extends State<ClassroomDialog> {
  late TextEditingController titleController;
  late List<dynamic> childs;
  late List<dynamic> lessons;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.classroom?.title ?? '');
    childs = widget.classroom?.childs ?? [];
    lessons = widget.classroom?.lessons ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.classroom == null ? 'Nueva Clase' : 'Editar Clase'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _editList(context, true),
              child: const Text('Editar Niños'),
            ),
            ElevatedButton(
              onPressed: () => _editList(context, false),
              child: const Text('Editar Lecciones'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _save,
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  void _editList(BuildContext context, bool isChilds) {
    // Implementar edición de listas
  }

  void _save() {
    final classroom = Classroom(
      id: widget.classroom?.id ?? '',
      title: titleController.text,
      childs: childs,
      lessons: lessons,
    );

    if (widget.classroom == null) {
      context.read<ApiBloc>().add(AddClassroom(classroom));
    } else {
      context.read<ApiBloc>().add(UpdateClassroom(classroom));
    }

    Navigator.pop(context);
  }
}
