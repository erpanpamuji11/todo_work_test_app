part of 'delete_todo_bloc.dart';

sealed class DeleteBlocState extends Equatable {
  const DeleteBlocState();

  @override
  List<Object> get props => [];
}

final class DeleteBlocInitial extends DeleteBlocState {}

final class DeleteBlocLoading extends DeleteBlocState {}

final class DeleteBlocFailed extends DeleteBlocState {
  final String message;

  const DeleteBlocFailed(this.message);

  @override
  List<Object> get props => [];
}

final class DeleteBlocLoaded extends DeleteBlocState {
  final Todo todo;
  const DeleteBlocLoaded(this.todo);

  @override
  List<Object> get props => [];
}
