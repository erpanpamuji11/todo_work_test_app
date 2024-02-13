import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

class PostTodoList {
  final TodoRepository todoRepository;

  PostTodoList(this.todoRepository);

  Future<Either<Failure, Todo>> addTodo(String title, category, createdAt) {
    return todoRepository.addTodo(title, category, createdAt);
  }
}
