
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_work_test_app/core/error/failure.dart';
import 'package:todo_work_test_app/domain/usecases/get_todo_list.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'todo_bloc_test.mocks.dart';

@GenerateMocks([GetTodoList])

void main(){
  late MockGetTodoList mockGetTodoList;
  late TodoBloc todoBloc;

  setUp(() {
    mockGetTodoList = MockGetTodoList();
    todoBloc = TodoBloc(mockGetTodoList);
  });

  test('the TodoBloc initial state should be empty ', () {
    expect(todoBloc.state, TodoInitial());
  });

  blocTest<TodoBloc, TodoState>(
      'should emits NowPlayingMovieLoading state and then NowPlayingMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetTodoList.execute())
            .thenAnswer((_) async => Right(testTodoList));
        return todoBloc;
      },
      act: (bloc) => bloc.add(OnGetTodoList()),
      expect: () => <TodoState>[
        TodoLoading(),
        TodoLoaded(testTodoList),
      ],
      verify: (bloc) {
        verify(mockGetTodoList.execute());
        return OnGetTodoList().props;
      });

  blocTest<TodoBloc, TodoState>(
    'should emits NowPlayingMovieLoading state and then NowPlayingMovieError state when data is failed fetched..',
    build: () {
      when(mockGetTodoList.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return todoBloc;
    },
    act: (bloc) => bloc.add(OnGetTodoList()),
    expect: () => <TodoState>[
      TodoLoading(),
      const TodoFailed('Server Failure'),
    ],
    verify: (bloc) => TodoLoading(),
  );

  blocTest<TodoBloc, TodoState>(
    'should emits NowPlayingMovieLoading state and then NowPlayingMovieEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTodoList.execute())
          .thenAnswer((_) async => const Right([]));
      return todoBloc;
    },
    act: (bloc) => bloc.add(OnGetTodoList()),
    expect: () => <TodoState>[
      TodoLoading(),
      const TodoLoaded([]),
    ],
  );
}