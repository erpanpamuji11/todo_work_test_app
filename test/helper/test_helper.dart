
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_work_test_app/data/data_sources/todo_data_source.dart';
import 'package:todo_work_test_app/domain/repositories/todo_repository.dart';

@GenerateMocks([
  TodoRepository,
  TodoDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient)
])

void main() {}