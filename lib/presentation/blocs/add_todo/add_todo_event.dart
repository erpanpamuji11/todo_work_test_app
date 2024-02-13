part of 'add_todo_bloc.dart';

sealed class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class OnPostTodoList extends AddTodoEvent {
  final String title;
  final String category;
  final String createdAt;

  const OnPostTodoList(this.title, this.category, this.createdAt);

  @override
  List<Object> get props => [title, category, createdAt];
}