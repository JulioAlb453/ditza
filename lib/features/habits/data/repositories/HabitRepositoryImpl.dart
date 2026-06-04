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
    final response = await api.post('/habits', body: habitData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return HabitModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear hábito');
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
  Future<Habit> updateHabit(String id) async {
    final response = await api.patch('/habits/$id/complete', body: {});

    if (response.statusCode == 200) {
      return HabitModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al completar hábito');
    }
  }
}
