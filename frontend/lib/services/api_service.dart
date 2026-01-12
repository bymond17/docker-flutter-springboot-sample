import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 빌드 시점에 주입된 BASE_URL을 읽어옵니다. 
  // 주입된 값이 없으면 개발 편의를 위해 localhost를 기본값으로 사용합니다.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:8080',
  );

  static Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/data'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data from $baseUrl');
      }
    } catch (e) {
      return {'message': 'Error: $e'};
    }
  }
}