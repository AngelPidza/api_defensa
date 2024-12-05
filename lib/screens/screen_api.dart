import 'package:api_defensa/api_bloc/api_bloc/api_bloc.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_state.dart';
import 'package:api_defensa/models/classroom.dart';
import 'package:api_defensa/screens/classroom_card.dart';
import 'package:api_defensa/screens/classroom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenApi extends StatelessWidget {
  const ScreenApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showClassroomDialog(context),
          )
        ],
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return ListView.builder(
            itemCount: state.classrooms.length,
            itemBuilder: (context, index) {
              final classroom = state.classrooms[index];
              return ClassroomCard(
                classroom: classroom,
                onEdit: () =>
                    _showClassroomDialog(context, classroom: classroom),
                onDelete: () =>
                    context.read<ApiBloc>().add(DeleteClassroom(classroom.id)),
              );
            },
          );
        },
      ),
    );
  }

  void _showClassroomDialog(BuildContext context, {Classroom? classroom}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<ApiBloc>(context),
        child: ClassroomDialog(classroom: classroom),
      ),
    );
  }
}
