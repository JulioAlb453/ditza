import '../entity/user.dart';
import '../repository/UserRepository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<User> call() async {
    return await repository.getCurrentUser();
  }
}
