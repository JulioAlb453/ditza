import '../entity/habit.dart';
import '../repository/HabitRepository.dart';

class CreateHabit {
  final HabitRepository repository;

  CreateHabit(this.repository);

  Future<Habit> call(String title) async {
    return await repository.createHabit(title);
  }
}
