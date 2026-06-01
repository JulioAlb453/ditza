import '../entity/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<User> createUser();
}
