import 'dart:convert';

import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_state.dart';
import 'package:api_defensa/models/classroom.dart';
import 'package:api_defensa/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String apiUrl =
      'https://674869495801f5153590c2a3.mockapi.io/api/v1/sergio';

  ApiBloc() : super(ApiInitial()) {
    on<LoadClassrooms>(_onLoadClassrooms);
    on<AddClassroom>(_onAddClassroom);
    on<UpdateClassroom>(_onUpdateClassroom);
    on<DeleteClassroom>(_onDeleteClassroom);
  }

  Future<void> _onLoadClassrooms(
      LoadClassrooms event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final classrooms =
            data.map((json) => Classroom.fromJson(json)).toList();
        emit(ApiLoaded(classrooms));
      } else {
        emit(ApiError('Error loading classrooms'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onAddClassroom(
      AddClassroom event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(event.classroom.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        add(LoadClassrooms());
      } else {
        emit(ApiError('Error creating classroom'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onUpdateClassroom(
      UpdateClassroom event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${event.classroom.id}'),
        body: json.encode(event.classroom.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        add(LoadClassrooms());
      } else {
        emit(ApiError('Error updating classroom'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }

  Future<void> _onDeleteClassroom(
      DeleteClassroom event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await http.delete(Uri.parse('$apiUrl/${event.id}'));
      if (response.statusCode == 200) {
        add(LoadClassrooms());
      } else {
        emit(ApiError('Error deleting classroom'));
      }
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}
