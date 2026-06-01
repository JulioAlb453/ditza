import '../entity/habit.dart';
import '../repository/HabitRepository.dart';

class UpdateHabit {
  final HabitRepository repository;

  UpdateHabit(this.repository);

  Future<Habit> call(String id) async {
    return await repository.updateHabit(id);
  }
}
