import 'package:get_it/get_it.dart';
import 'package:todo_work_test_app/data/data_sources/todo_data_source.dart';
import 'package:todo_work_test_app/data/repositories/todo_repository_impl.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';
import 'package:todo_work_test_app/domain/usecases/delete_todo_list.dart';
import 'package:todo_work_test_app/domain/usecases/get_todo_list.dart';
import 'package:todo_work_test_app/domain/usecases/post_todo_list.dart';
import 'package:todo_work_test_app/domain/usecases/put_todo_list.dart';
import 'package:todo_work_test_app/presentation/blocs/add_todo/add_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_work_test_app/presentation/blocs/update_bloc/update_todo_bloc.dart';

final sl = GetIt.instance;

void setupSl(){

  //bloc
  sl.registerFactory(() => TodoBloc(sl()));
  sl.registerFactory(() => AddTodoBloc(sl()),);
  sl.registerFactory(() => UpdateTodoBloc(sl()));
  sl.registerFactory(() => DeleteBlocBloc(sl()));

  //usecase
  sl.registerLazySingleton(() => GetTodoList(sl()));
  sl.registerLazySingleton(() => PostTodoList(sl()));
  sl.registerLazySingleton(() => PutTodoList(sl()));
  sl.registerLazySingleton(() => DeleteTodoList(sl()));

  //repo
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  //datasource
  sl.registerLazySingleton<TodoDataSource>(() => TodoDataSourceImpl(sl()));

  //external
  sl.registerLazySingleton(() => http.Client());
}