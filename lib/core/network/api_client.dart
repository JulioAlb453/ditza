import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = 'http://34.201.68.191';
  final http.Client _client = http.Client();

  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };

  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    developer.log('GET $url', name: 'ApiClient');
    
    final response = await _client.get(url, headers: {...defaultHeaders, ...?headers});
    
    _logResponse(response);
    return response;
  }

  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    developer.log('POST $url', name: 'ApiClient');
    if (body != null) developer.log('Body: $body', name: 'ApiClient');

    final response = await _client.post(
      url,
      headers: {...defaultHeaders, ...?headers},
      body: body,
    );

    _logResponse(response);
    return response;
  }

  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    developer.log('PATCH $url', name: 'ApiClient');
    if (body != null) developer.log('Body: $body', name: 'ApiClient');

    final response = await _client.patch(
      url,
      headers: {...defaultHeaders, ...?headers},
      body: body,
    );

    _logResponse(response);
    return response;
  }

  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    developer.log('DELETE $url', name: 'ApiClient');

    final response = await _client.delete(url, headers: {...defaultHeaders, ...?headers});

    _logResponse(response);
    return response;
  }

  void _logResponse(http.Response response) {
    final status = response.statusCode;
    final body = response.body;
    
    if (status >= 200 && status < 300) {
      developer.log('Response [$status]: $body', name: 'ApiClient');
    } else {
      developer.log('ERROR [$status]: $body', name: 'ApiClient', level: 1000);
    }
  }
}
