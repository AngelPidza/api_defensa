import 'dart:convert';

import 'package:api_defensa/api_bloc/transaction_state.dart';
import 'package:api_defensa/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Cubit<TransactionState> {
  final String apiUrl =
      'https://674869495801f5153590c2a3.mockapi.io/api/v1/transaction';

  TransactionBloc() : super(TransactionState(isLoading: true));

  get http => null;

  Future<void> loadTransactions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
        emit(TransactionState(transactions: transactions));
      } else {
        emit(TransactionState(
            error: 'Error al cargar datos: ${response.statusCode}'));
      }
    } catch (e) {
      emit(TransactionState(error: e.toString()));
    }
  }
}
