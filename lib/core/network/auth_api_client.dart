import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shared/shared_prefs_service.dart';
import 'api_client.dart';

class AuthApiClient extends ApiClient {
  final SharedPreferencesService _prefs;

  AuthApiClient(this._prefs);

  @override
  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final token = _prefs.getToken();
    return super.get(endpoint, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    });
  }

  @override
  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final token = _prefs.getToken();
    return super.post(endpoint, body: body, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    });
  }

  @override
  Future<http.Response> patch(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final token = _prefs.getToken();
    return super.patch(endpoint, body: body, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    });
  }

  @override
  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final token = _prefs.getToken();
    return super.delete(endpoint, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    });
  }
}
