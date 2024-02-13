import 'package:equatable/equatable.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  String id;
  String title;
  String category;
  String createdAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        title: json["title"],
        category: json["category"],
        createdAt: json["createdAt"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "createdAt": createdAt,
        "id": id,
      };

  Todo toEntity() =>
      Todo(title: title, category: category, createdAt: createdAt, id: id);

  @override
  List<Object?> get props => [id, title, category, createdAt];
}
