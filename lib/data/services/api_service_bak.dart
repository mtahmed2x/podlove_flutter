import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    try {
      final response = await http.post(url, headers: {
        'Content-type': 'application/json',
      },
        body: json.encode(data),
      );
      return json.decode(response.body) as Map<String, dynamic>;
    } catch(e) {
      throw Exception("Failed to connect : $e");
    }
  }
}