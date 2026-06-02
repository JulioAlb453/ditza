import 'dart:convert';
import 'package:http/http.dart' as http;
import '../auth/auth_service.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  final AuthService _authService;

  ApiClient({
    required this.baseUrl,
    required AuthService authService,
    http.Client? client,
  })  : _authService = authService,
        _client = client ?? http.Client();

  Future<Map<String, String>> _getHeaders([Map<String, String>? customHeaders]) async {
    final token = await _authService.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  /// GET
  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final combinedHeaders = await _getHeaders(headers);
    return await _client.get(url, headers: combinedHeaders);
  }

  /// POST
  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final combinedHeaders = await _getHeaders(headers);
    return await _client.post(
      url,
      headers: combinedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// PATCH
  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final combinedHeaders = await _getHeaders(headers);
    return await _client.patch(
      url,
      headers: combinedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// DELETE
  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final combinedHeaders = await _getHeaders(headers);
    return await _client.delete(url, headers: combinedHeaders);
  }
}
