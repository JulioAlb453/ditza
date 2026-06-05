import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shared/shared_prefs_service.dart';
import 'api_client.dart';

class AuthApiClient extends ApiClient {
  final SharedPreferencesService _prefs;

  AuthApiClient(this._prefs);

  @override
  Map<String, String> get defaultHeaders {
    final token = _prefs.getToken();
    return {
      ...super.defaultHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    return super.get(endpoint, headers: headers);
  }

  @override
  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    return super.post(endpoint, body: body, headers: headers);
  }

  @override
  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body}) async {
    return super.patch(endpoint, body: body, headers: headers);
  }

  @override
  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    return super.delete(endpoint, headers: headers);
  }
}
