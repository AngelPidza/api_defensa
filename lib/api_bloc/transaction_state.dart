import 'package:api_defensa/models/transaction.dart';

class TransactionState {
  final List<Transaction> transactions;
  final bool isLoading;
  final String? error;

  TransactionState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });
}
