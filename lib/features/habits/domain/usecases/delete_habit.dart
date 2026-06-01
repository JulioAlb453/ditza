import '../repository/HabitRepository.dart';

class DeleteHabit {
  final HabitRepository repository;

  DeleteHabit(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteHabit(id);
  }
}
