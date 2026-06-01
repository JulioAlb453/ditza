import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET
  Future<http.Response> get(String endpoint, {Map<String, String>? headers})  {
    final url = Uri.parse('$baseUrl$endpoint');
    return  _client.get(url);
  }

  /// POST
  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body})  {
    final url = Uri.parse('$baseUrl$endpoint');
    return  _client.post(
      url,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// PATCH
  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body})  {
    final url = Uri.parse('$baseUrl$endpoint');
    return  _client.patch(
      url,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// DELETE
  Future<http.Response> delete(String endpoint, {Map<String, String>? headers})  {
    final url = Uri.parse('$baseUrl$endpoint');
    return  _client.delete(url);
  }

}
