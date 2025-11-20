import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;
  final String priority; // low, medium, high

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
    this.priority = 'medium',
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isDone,
    String? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, isDone, priority];
}