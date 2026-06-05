import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = 'http://34.201.68.191:8080';
  final http.Client _client = http.Client();

  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await _client.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    });
  }

  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await _client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await _client.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await _client.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    });
  }
}
