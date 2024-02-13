part of 'update_todo_bloc.dart';

sealed class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();

  @override
  List<Object> get props => [];
}

class OnPutTodoList extends UpdateTodoEvent {
  final String title;
  final String category;
  final String createdAt;
  final String id;

  const OnPutTodoList(this.title, this.category, this.createdAt, this.id);

  @override
  List<Object> get props => [title, category, createdAt, id];
}