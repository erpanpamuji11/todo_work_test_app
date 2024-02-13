import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/core/error/error/exception.dart';
import 'package:todo_work_test_app/core/error/error/failure.dart';
import 'package:todo_work_test_app/data/data_sources/todo_data_source.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;

  TodoRepositoryImpl(this.todoDataSource);

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    try {
      final result = await todoDataSource.getTodoList();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("failed to connect to the network"));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> addTodo(String title, category, createdAt) async {
    try {
      final result = await todoDataSource.addTodo(title, category, createdAt);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("failed to connect to the network"));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> deleteTodo(int id) async {
    try {
      final result = await todoDataSource.deleteTodo(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("failed to connect to the network"));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> updateTodo(String title, category, createdAt, id) async {
    try {
      final result = await todoDataSource.updateTodo(title, category, createdAt, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("failed to connect to the network"));
    }
  }
}
