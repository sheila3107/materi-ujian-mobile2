import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_cubit.dart';
import '../models/todo_model.dart';
import '../widgets/todo_card.dart';
import 'todo_detail_page.dart';
import 'todo_grid_page.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  String priority = 'medium';

  void _addTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Tugas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            DropdownButtonFormField<String>(
              value: priority,
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'high', child: Text('High')),
              ],
              onChanged: (value) => setState(() => priority = value!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                context.read<TodoCubit>().addTodo(
                      titleController.text,
                      descController.text,
                      priority,
                    );
                titleController.clear();
                descController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TodoGridPage()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          final cubit = context.read<TodoCubit>();

          return Column(
            children: [
              // ========= DASHBOARD COUNTERS =========
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCountCard(
                      title: "Total",
                      count: cubit.totalTodo,
                      color: Colors.blue,
                    ),
                    _buildCountCard(
                      title: "Selesai",
                      count: cubit.totalDone,
                      color: Colors.green,
                    ),
                    _buildCountCard(
                      title: "Belum",
                      count: cubit.totalPending,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),

              // ========= LIST TODO =========
              Expanded(
                child: todos.isEmpty
                    ? const Center(child: Text('Belum ada tugas'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
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
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ========== CARD COUNTER WIDGET ==========
  Widget _buildCountCard({
    required String title,
    required int count,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
