import 'package:api_defensa/models/classroom.dart';
import 'package:api_defensa/models/transaction.dart';

// api_event.dart
abstract class ApiEvent {}

class LoadTransactions extends ApiEvent {}

class DeleteTransaction extends ApiEvent {
  final String id;
  DeleteTransaction(this.id);
}

class UpdateTransaction extends ApiEvent {
  final Transaction transaction;
  UpdateTransaction(this.transaction);
}

class AddTransaction extends ApiEvent {
  final Transaction transaction;
  AddTransaction(this.transaction);
}

class LoadClassrooms extends ApiEvent {}

class AddClassroom extends ApiEvent {
  final Classroom classroom;
  AddClassroom(this.classroom);
}

class UpdateClassroom extends ApiEvent {
  final Classroom classroom;
  UpdateClassroom(this.classroom);
}

class DeleteClassroom extends ApiEvent {
  final String id;
  DeleteClassroom(this.id);
}
