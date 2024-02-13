import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/usecases/delete_todo_list.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteBlocBloc extends Bloc<DeleteBlocEvent, DeleteBlocState> {
  final DeleteTodoList deleteTodoList;
  DeleteBlocBloc(this.deleteTodoList) : super(DeleteBlocInitial()) {
    on<OnDeleteTodo>((event, emit) async {
      emit(DeleteBlocLoading());

      final result = await deleteTodoList.deleteTodo(event.id);
      result.fold(
        (l) => emit(
          DeleteBlocFailed(l.message),
        ),
        (r) => emit(
          DeleteBlocLoaded(r),
        ),
      );
    });
  }
}
