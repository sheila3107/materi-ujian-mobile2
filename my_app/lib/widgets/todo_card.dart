import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onToggle,
  });

  Color get priorityColor {
    switch (todo.priority) {
      case 'high': return Colors.redAccent;
      case 'low': return Colors.green;
      default: return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: todo.id,
      child: Stack(
        children: [
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              onTap: onTap,
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) => onToggle(),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                todo.priority.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}