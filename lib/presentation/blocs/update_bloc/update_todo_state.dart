part of 'update_todo_bloc.dart';

sealed class UpdateTodoState extends Equatable {
  const UpdateTodoState();
  
  @override
  List<Object> get props => [];
}

final class UpdateTodoInitial extends UpdateTodoState {}

final class UpdateTodoLoading extends UpdateTodoState {}

final class UpdateTodoFailed extends UpdateTodoState {
  final String message;

  const UpdateTodoFailed(this.message);
  @override
  List<Object> get props => [message];
}

final class UpdateTodoLoaded extends UpdateTodoState {
  final Todo todo;

  const UpdateTodoLoaded(this.todo);

  @override
  List<Object> get props => [todo];
}
