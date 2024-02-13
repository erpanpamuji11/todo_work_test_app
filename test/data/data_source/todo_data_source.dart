import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_work_test_app/core/error/exception.dart';
import 'package:todo_work_test_app/core/utils/baseUrl_utils.dart';
import 'package:todo_work_test_app/data/data_sources/todo_data_source.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late TodoDataSource datasource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    datasource = TodoDataSourceImpl(mockIOClient);
  });

  const tUrl = BaseUrl.url;

  const String sampleApiResponse = '''
[
    {
        "title": "ghhhh",
        "category": "daily",
        "createdAt": "13 Feb",
        "id": "1"
    },
    {
        "title": "fgggg",
        "category": "daily",
        "createdAt": "13 Feb",
        "id": "2"
    },
    {
        "title": "",
        "category": "birthday",
        "createdAt": "13 Feb",
        "id": "3"
    },
    {
        "title": "ghhhh",
        "category": "daily",
        "createdAt": "13 Feb",
        "id": "4"
    }
]
''';

  test('should perfom a GET request on a url to get todo list', () async {
    // arrange
    when(mockIOClient.get(Uri.parse(tUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // act
    await datasource.getTodoList();

    // assert
    verify(mockIOClient.get(Uri.parse(tUrl)));
  });

  test('should throw a ServerException when the response code is 404',
          () async {
        // arrange
        when(mockIOClient.get(any))
            .thenAnswer((_) async => http.Response('Something went wrong', 404));

        // act
        final call = datasource.getTodoList();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
}
