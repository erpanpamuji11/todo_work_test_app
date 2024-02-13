import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  String title;
  String category;
  String createdAt;
  String id;

  Todo({
    required this.title,
    required this.category,
    required this.createdAt,
    required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, category, createdAt];
}
