import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_cubit.dart';
import '../models/todo_model.dart';
import '../widgets/todo_card.dart';
import 'todo_detail_page.dart';

class TodoGridPage extends StatelessWidget {
  const TodoGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid View')),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Tidak ada tugas'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.1,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoCard(
                todo: todo,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TodoDetailPage(todo: todo),
                  ),
                ),
                onDelete: () =>
                    context.read<TodoCubit>().removeTodo(todo.id),
                onToggle: () =>
                    context.read<TodoCubit>().toggleTodo(todo.id),
              );
            },
          );
        },
      ),
    );
  }
}