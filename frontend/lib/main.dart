import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter + Spring Boot')),
        body: const Center(child: ApiResultWidget()),
      ),
    );
  }
}

class ApiResultWidget extends StatefulWidget {
  const ApiResultWidget({super.key});

  @override
  State<ApiResultWidget> createState() => _ApiResultWidgetState();
}

class _ApiResultWidgetState extends State<ApiResultWidget> {
  String _message = "데이터를 가져오는 중...";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
  final result = await ApiService.fetchData(); // 인스턴스 대신 클래스명으로 호출
  setState(() {
    _message = result['message'] ?? '데이터 없음';
  });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_message, style: const TextStyle(fontSize: 20));
  }
}