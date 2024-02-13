import 'package:flutter/material.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/injection.dart';
import 'package:todo_work_test_app/presentation/blocs/add_todo/add_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/update_bloc/update_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/add_todo_page.dart';
import 'package:todo_work_test_app/presentation/pages/detail_todo_page.dart';
import 'package:todo_work_test_app/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/intro_page.dart';

void main() {
  setupSl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<TodoBloc>()),
          BlocProvider(create: (_) => sl<AddTodoBloc>()),
          BlocProvider(create: (_) => sl<UpdateTodoBloc>()),
          BlocProvider(create: (_) => sl<DeleteBlocBloc>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
            useMaterial3: true,
          ),
          initialRoute: IntroPage.introPage,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case HomePage.homePage:
                return MaterialPageRoute(
                  builder: (context) => const HomePage(),
                );
              case AddTodoPage.addTodoPage:
                return MaterialPageRoute(
                  builder: (context) => AddTodoPage(),
                );
              case DetailTodoPage.detailTodoPage:
                final data = settings.arguments as Todo;
                return MaterialPageRoute(
                  builder: (context) => DetailTodoPage(todo: data),
                );
              case IntroPage.introPage:
                return MaterialPageRoute(
                  builder: (context) => const IntroPage(),
                );
            }
            return null;
          },
        ));
  }
}
