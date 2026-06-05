import 'dart:convert';
import 'package:ditza/core/network/auth_api_client.dart';
import '../../domain/entity/habit.dart';
import '../../domain/repository/HabitRepository.dart';
import '../models/HabitModel.dart';

class HabitRepositoryImpl implements HabitRepository {
  final AuthApiClient api;

  HabitRepositoryImpl({required this.api});

  @override
  Future<List<Habit>> getHabits() async {
    final response = await api.get('/habits');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => HabitModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener hábitos: ${response.statusCode}');
    }
  }

  @override
  Future<Habit> createHabit(Map<String, dynamic> habitData) async {
    final response = await api.post('/habits', body: jsonEncode(habitData));

    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        return HabitModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print('Error al mapear HabitModel: $e');
        throw Exception('Error en el formato de respuesta del servidor');
      }
    } else {
      String errorMessage = 'Error al crear hábito';
      try {
        final errorBody = jsonDecode(response.body);
        errorMessage = errorBody['message'] ?? errorBody['error'] ?? errorMessage;
      } catch (_) {
        errorMessage = 'Error del servidor: ${response.statusCode}';
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<void> deleteHabit(String id) async {
    final response = await api.delete('/habits/$id');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar hábito');
    }
  }

  @override
  Future<Habit> updateHabit(String id, Map<String, dynamic> habitData) async {
    final response = await api.patch('/habits/$id', body: jsonEncode(habitData));

    if (response.statusCode == 200) {
      return HabitModel.fromJson(jsonDecode(response.body));
    } else {
      String errorMessage = 'Error al actualizar hábito';
      try {
        final errorBody = jsonDecode(response.body);
        errorMessage = errorBody['message'] ?? errorBody['error'] ?? errorMessage;
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }
}
