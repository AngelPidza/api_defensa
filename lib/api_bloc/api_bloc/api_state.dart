import 'package:api_defensa/models/transaction.dart';

abstract class ApiState {
  final List<Transaction> transactions;
  final bool isLoading;
  final String? error;

  ApiState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {
  ApiLoading() : super(isLoading: true);
}

class ApiLoaded extends ApiState {
  ApiLoaded(List<Transaction> transactions) : super(transactions: transactions);
}

class ApiError extends ApiState {
  ApiError(String message) : super(error: message);
}
