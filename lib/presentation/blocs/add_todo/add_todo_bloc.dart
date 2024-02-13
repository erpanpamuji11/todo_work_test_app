import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/usecases/post_todo_list.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final PostTodoList postTodoList;
  AddTodoBloc(this.postTodoList) : super(AddTodoInitial()) {
    on<OnPostTodoList>((event, emit) async {
      emit(AddTodoLoading());

      final result = await postTodoList.addTodo(
          event.title, event.category, event.createdAt);
      result.fold((l) {
        emit(AddTodoFailed(l.message));
      }, (r) {
        emit(AddTodoLoaded(r));
      });
    });
  }
}
