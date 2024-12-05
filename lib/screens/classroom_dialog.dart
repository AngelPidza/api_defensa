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
  late List<TextEditingController> childsControllers;
  late List<TextEditingController> lessonsControllers;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.classroom?.title ?? '');
    childsControllers = (widget.classroom?.childs ?? [])
        .map((child) => TextEditingController(text: child.toString()))
        .toList();
    lessonsControllers = (widget.classroom?.lessons ?? [])
        .map((lesson) => TextEditingController(text: lesson.toString()))
        .toList();
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
            _buildListSection('Niños', childsControllers),
            _buildListSection('Lecciones', lessonsControllers),
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

  Widget _buildListSection(
      String title, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addItem(controllers),
            ),
          ],
        ),
        ...controllers.asMap().entries.map((entry) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: entry.value,
                  decoration:
                      InputDecoration(labelText: '${title} ${entry.key + 1}'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => _removeItem(controllers, entry.key),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _addItem(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void _removeItem(List<TextEditingController> controllers, int index) {
    setState(() {
      controllers[index].dispose();
      controllers.removeAt(index);
    });
  }

  void _save() {
    final classroom = Classroom(
      id: widget.classroom?.id ?? '',
      title: titleController.text,
      childs: childsControllers.map((c) => c.text).toList(),
      lessons: lessonsControllers.map((c) => c.text).toList(),
    );

    if (widget.classroom == null) {
      context.read<ApiBloc>().add(AddClassroom(classroom));
    } else {
      context.read<ApiBloc>().add(UpdateClassroom(classroom));
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    for (var controller in childsControllers) {
      controller.dispose();
    }
    for (var controller in lessonsControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
