import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/error/failure.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

class DeleteTodoList {
  final TodoRepository todoRepository;

  DeleteTodoList(this.todoRepository);

  Future<Either<Failure, Todo>> deleteTodo(int id) {
    return todoRepository.deleteTodo(id);
  }
}