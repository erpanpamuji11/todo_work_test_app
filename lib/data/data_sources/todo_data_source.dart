import 'dart:convert';
import 'package:todo_work_test_app/core/error/error/exception.dart';
import 'package:todo_work_test_app/core/utils/baseUrl_utils.dart';
import 'package:todo_work_test_app/data/models/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class TodoDataSource {
  Future<List<TodoModel>> getTodoList();
  Future<TodoModel> addTodo(String title, category, createdAt);
  Future<TodoModel> updateTodo(String title, category, createdAt, id);
  Future<TodoModel> deleteTodo(int id);
}

class TodoDataSourceImpl extends TodoDataSource {
  final http.Client client;

  TodoDataSourceImpl(this.client);

  @override
  Future<List<TodoModel>> getTodoList() async {
    final response = await client.get(Uri.parse(BaseUrl.url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> addTodo(String title, category, createdAt) async {
    final response = await client.post(Uri.parse(BaseUrl.url), body: {
      "title": title,
      "category": category,
      "createdAt": createdAt
    });
    if (response.statusCode == 200){
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TodoModel> deleteTodo(int id) async {
    final response = await client.delete(Uri.parse("${BaseUrl.url}/$id"));
    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TodoModel> updateTodo(String title, category, createdAt, id) async {
    final response = await client.put(Uri.parse("${BaseUrl.url}/$id"), body: {
      "title": title,
      "category": category,
      "createdAt": createdAt
    });
    if (response.statusCode == 200){
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
