import '../entity/habit.dart';

abstract class HabitRepository {
  Future<List<Habit>> getHabits();
  Future<Habit> createHabit(Map<String, dynamic> habitData);
  Future<void> deleteHabit(String id);
  Future<Habit> updateHabit(String id);
}
