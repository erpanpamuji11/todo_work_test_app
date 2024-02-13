import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

class GetTodoList {
  final TodoRepository todoRepository;

  GetTodoList(this.todoRepository);

  Future<Either<Failure, List<Todo>>> execute() {
    return todoRepository.getTodoList();
  }
}
