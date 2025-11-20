import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;
  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Hero(
        tag: todo.id,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text('Prioritas: ${todo.priority.toUpperCase()}'),
              const SizedBox(height: 10),
              Text('Tanggal dibuat: ${todo.date}'),
              const Divider(),
              Text(todo.description),
            ],
          ),
        ),
      ),
    );
  }
}