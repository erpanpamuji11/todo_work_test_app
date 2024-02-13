

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/home_page.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/page_test_helper.dart';

void main() {
  late FakeTodoBloc fakeTodoBloc;

  setUp(() {
    fakeTodoBloc = FakeTodoBloc();
    registerFallbackValue(FakeTodoEvent());
    registerFallbackValue(FakeMovieState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeTodoBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => fakeTodoBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'page should display listview of NowPlayingMovies when HasData state is happen',
          (WidgetTester tester) async {
        when(() => fakeTodoBloc.state)
            .thenReturn(TodoLoaded(testTodoList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(const HomePage()));

        expect(listViewFinder, findsWidgets);
      });
}