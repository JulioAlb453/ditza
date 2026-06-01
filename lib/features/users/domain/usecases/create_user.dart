import '../entity/user.dart';
import '../repository/UserRepository.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<User> call() async {
    return await repository.createUser();
  }
}
