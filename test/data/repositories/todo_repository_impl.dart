
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_work_test_app/core/error/exception.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/data/models/todo_model.dart';
import 'package:todo_work_test_app/data/repositories/todo_repository_impl.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoDataSource mockTodoDataSource;

  setUp(() {
    mockTodoDataSource = MockTodoDataSource();
    repository = TodoRepositoryImpl(mockTodoDataSource);
  });

  final tTodoModelList = [
  TodoModel(
    title: "todo 1",
    category: "daily",
    createdAt: "11 Mey",
    id: "1",
  ),
    TodoModel(
      title: "todo 1",
      category: "daily",
      createdAt: "11 Mey",
      id: "1",
    ),
  ];

  final tTodoList = [
  Todo(
    title: "todo 1",
    category: "daily",
    createdAt: "11 Mey",
    id: "1",
  ),
    Todo(
      title: "todo 1",
      category: "daily",
      createdAt: "11 Mey",
      id: "1",
    ),
  ];

  test('should get now playing movies from the remote data source', () async {
    when(mockTodoDataSource.getTodoList())
        .thenAnswer((_) async => tTodoModelList);

    final result = await repository.getTodoList();

    verify(mockTodoDataSource.getTodoList());

    expect(result, isA<Right<Failure, List<Todo>>>());
  });

  test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockTodoDataSource.getTodoList()).thenThrow(ServerException());
        // act
        final result = await repository.getTodoList();
        // assert
        verify(mockTodoDataSource.getTodoList());
        expect(result, equals(const Left(ServerFailure('An error has occured'))));
      });

  test(
      'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockTodoDataSource.getTodoList())
            .thenThrow(const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTodoList();
        // assert
        verify(mockTodoDataSource.getTodoList());
        expect(result,
            equals(const Left(ConnectionFailure('failed to connect to the network'))));
      });
}
