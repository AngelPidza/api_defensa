import 'package:api_defensa/api_bloc/api_bloc/api_bloc.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/screens/screen_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => ApiBloc()..add(LoadTransactions()),
        child: const ScreenApi(),
      ),
    );
  }
}
