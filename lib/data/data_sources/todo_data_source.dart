import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_work_test_app/core/error/exception.dart';
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
    try {
      final response = await client.get(Uri.parse("${BaseUrl.url}/todos")).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
    } catch (e){
      debugPrint("failed : $e");

      if (e is SocketException) {
        throw OfflineException();
      }
      if (e is TimeoutException) {
        throw TimeOutExceptionss();
      }
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> addTodo(String title, category, createdAt) async {
    final response = await client.post(Uri.parse("${BaseUrl.url}/todos"), body: {
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
    final response = await client.delete(Uri.parse("${BaseUrl.url}/todos/$id"));
    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TodoModel> updateTodo(String title, category, createdAt, id) async {
    final response = await client.put(Uri.parse("${BaseUrl.url}/todos/$id"), body: {
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
