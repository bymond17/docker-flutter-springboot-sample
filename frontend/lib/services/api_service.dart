import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 웹 브라우저에서 실행 시 로컬 백엔드 주소
  static const String baseUrl = "http://localhost:8080";

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/data'));

      if (response.statusCode == 200) {
        // 한글 깨짐 방지를 위해 utf8.decode 사용
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('서버 연결 실패: ${response.statusCode}');
      }
    } catch (e) {
      return {'message': '에러 발생: $e'};
    }
  }
}