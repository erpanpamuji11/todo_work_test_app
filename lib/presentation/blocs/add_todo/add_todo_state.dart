part of 'add_todo_bloc.dart';

sealed class AddTodoState extends Equatable {
  const AddTodoState();
  
  @override
  List<Object> get props => [];
}

final class AddTodoInitial extends AddTodoState {}

final class AddTodoLoading extends AddTodoState {}

final class AddTodoFailed extends AddTodoState {
  final String message;

  const AddTodoFailed(this.message);
  @override
  List<Object> get props => [message];
}

final class AddTodoLoaded extends AddTodoState {
  final Todo todo;

  const AddTodoLoaded(this.todo);

  @override
  List<Object> get props => [todo];
}
