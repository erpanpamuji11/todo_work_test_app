import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/domain/usecases/put_todo_list.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  final PutTodoList putTodoList;
  UpdateTodoBloc(this.putTodoList) : super(UpdateTodoInitial()) {
    on<OnPutTodoList>((event, emit) async {
      emit(UpdateTodoLoading());

      final result = await putTodoList.updateTodo(
          event.title, event.category, event.createdAt, event.id);
      result.fold((l) {
        emit(UpdateTodoFailed(l.message));
      }, (r) {
        emit(UpdateTodoLoaded(r));
      });
    });
  }
}
