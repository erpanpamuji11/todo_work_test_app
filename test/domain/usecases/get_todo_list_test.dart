import 'package:dartz/dartz.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/usecases/get_todo_list.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTodoList usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodoList(mockTodoRepository);
  });

  final tTodoList = [
    Todo(
      title: "todo 1",
      category: "daily",
      createdAt: "11 Mey",
      id: "1",
    ),
    Todo(
      title: "todo 2",
      category: "daily",
      createdAt: "23 Mey",
      id: "2",
    ),
  ];

  test("should get todo list from repository", () async {
    //arrage
    when(mockTodoRepository.getTodoList()).thenAnswer(
      (_) async => Right(tTodoList),
    );

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTodoList));
    verify(mockTodoRepository.getTodoList());
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
