import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../core/shared/shared_prefs_service.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient api;
  final SharedPreferencesService authService;

  AuthRepositoryImpl({required this.api, required this.authService});

  @override
  Future<String> login(String email, String password) async {
    final response = await api.post('/auth/login', body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'] as String;
      await authService.saveToken(token);
      return token;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Error al iniciar sesión');
    }
  }

  @override
  Future<void> register(String alias, String email, String password) async {
    final response = await api.post('/auth/register', body: {
      'alias': alias,
      'email': email,
      'password': password,
    });

    if (response.statusCode != 201) {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Error al registrarse');
    }
  }

  @override
  Future<void> logout() async {
    await authService.deleteToken();
  }
}
