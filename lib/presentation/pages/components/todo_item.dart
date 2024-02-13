import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: todo.category,
                  child: Icon(
                    todo.category == "daily"
                        ? Icons.check_circle_outline_rounded
                        : todo.category == "task"
                            ? Icons.file_copy
                            : todo.category == "birthday"
                                ? Icons.cake_rounded
                                : Icons.school_rounded,
                    color: Colors.blue.shade600,
                    size: 27,
                  ),
                ),
                Gap(12),
                Flexible(
                  child: Text(
                    todo.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          Text(
            todo.createdAt,
          )
        ],
      ),
    );
  }
}
