
import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodoList();
  Future<Either<Failure, Todo>> addTodo(String title, category, createdAt);
  Future<Either<Failure, Todo>> updateTodo(String title, category, createdAt, id);
  Future<Either<Failure, Todo>> deleteTodo(int id);
}