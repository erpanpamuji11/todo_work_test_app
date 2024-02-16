
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'))
        .timeout(const Duration(seconds: 10)); // Set timeout to 10 seconds

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data received: ${response.body}');
    } else {
      // Handle other status codes
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle timeout or other exceptions
    print('Error: $e');
  }
}