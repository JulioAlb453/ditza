import '../entity/habit.dart';
import '../repository/HabitRepository.dart';

class UpdateHabit {
  final HabitRepository repository;

  UpdateHabit(this.repository);

  Future<Habit> call(String id, Map<String, dynamic> habitData) async {
    return await repository.updateHabit(id, habitData);
  }
}
