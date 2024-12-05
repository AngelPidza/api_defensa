import 'dart:convert';

import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_state.dart';
import 'package:api_defensa/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String apiUrl =
      'https://674869495801f5153590c2a3.mockapi.io/api/v1/transaction';

  ApiBloc() : super(ApiInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
      LoadTransactions event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
        emit(ApiLoaded(transactions));
      } else {
        emit(ApiError('Error al cargar datos'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
      AddTransaction event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(event.transaction.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        add(LoadTransactions());
      } else {
        emit(ApiError('Error al crear transacción'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onUpdateTransaction(
      UpdateTransaction event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${event.transaction.id}'),
        body: json.encode(event.transaction.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        add(LoadTransactions());
      } else {
        emit(ApiError('Error al actualizar transacción'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
      DeleteTransaction event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.delete(Uri.parse('$apiUrl/${event.id}'));
      if (response.statusCode == 200) {
        add(LoadTransactions());
      } else {
        emit(ApiError('Error al eliminar transacción'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}
