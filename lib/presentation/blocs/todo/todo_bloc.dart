import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/usecases/get_todo_list.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoList getTodoList;
  TodoBloc(this.getTodoList) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      emit(TodoLoading());

      final result = await getTodoList.execute();
      result.fold((fail) {
        emit(TodoFailed(fail.message));
      }, (data) {
        emit(TodoLoaded(data.reversed.toList()));
      });
    });
  }
}
