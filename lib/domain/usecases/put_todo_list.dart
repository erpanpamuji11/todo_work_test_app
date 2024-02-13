
import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

class PutTodoList {
  final TodoRepository todoRepository;

  PutTodoList(this.todoRepository);

  Future<Either<Failure, Todo>> updateTodo(String title, category, createdAt, id) {
    return todoRepository.updateTodo(title, category, createdAt, id);
  }
}