import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todo_cubit.dart';
import 'pages/todo_home_page.dart';

void main() => runApp(const AdvancedTodoApp());

class AdvancedTodoApp extends StatelessWidget {
  const AdvancedTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Advanced Flutter BLoC To-Do',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blueAccent,
        ),
        home: const TodoHomePage(),
      ),
    );
  }
}