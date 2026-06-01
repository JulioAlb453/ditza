import '../entity/habit.dart';
import '../repository/HabitRepository.dart';

class GetHabits {
  final HabitRepository repository;

  GetHabits(this.repository);

  Future<List<Habit>> call() async {
    return await repository.getHabits();
  }
}
