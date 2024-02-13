

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';

class FakeTodoEvent extends Fake implements TodoEvent {}

class FakeMovieState extends Fake implements TodoState {}

class FakeTodoBloc
    extends MockBloc<TodoEvent, TodoState>
    implements TodoBloc {}