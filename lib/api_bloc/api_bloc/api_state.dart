// api_state.dart
import 'package:api_defensa/models/classroom.dart';

abstract class ApiState {
  final List<Classroom> classrooms;
  final bool isLoading;
  final String? error;

  ApiState({
    this.classrooms = const [],
    this.isLoading = false,
    this.error,
  });
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {
  ApiLoading() : super(isLoading: true);
}

class ApiLoaded extends ApiState {
  ApiLoaded(List<Classroom> classrooms) : super(classrooms: classrooms);
}

class ApiError extends ApiState {
  ApiError(String message) : super(error: message);
}
