import 'dart:convert';
import 'package:ditza/core/network/api_client.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/UserRepository.dart';
import '../models/UserModel.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient api;

  UserRepositoryImpl({required this.api});

  @override
  Future<User> getCurrentUser() async {
    final response = await api.get('/me');

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener usuario: ${response.statusCode}');
    }
  }

  @override
  Future<User> createUser() async {
    final response = await api.post('/auth/register', body: {});

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al registrar usuario');
    }
  }
}
