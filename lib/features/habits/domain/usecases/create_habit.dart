import '../entity/habit.dart';
import '../repository/HabitRepository.dart';

class CreateHabit {
  final HabitRepository repository;

  CreateHabit(this.repository);

  Future<Habit> call(Map<String, dynamic> habitData) async {
    return await repository.createHabit(habitData);
  }
}
