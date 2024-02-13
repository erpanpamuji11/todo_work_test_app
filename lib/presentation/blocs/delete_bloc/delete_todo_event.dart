part of 'delete_todo_bloc.dart';

sealed class DeleteBlocEvent extends Equatable {
  const DeleteBlocEvent();

  @override
  List<Object> get props => [];
}

class OnDeleteTodo extends DeleteBlocEvent {
  final int id;

  const OnDeleteTodo(this.id);

  @override
  List<Object> get props => [id];
}