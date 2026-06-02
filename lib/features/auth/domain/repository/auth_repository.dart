abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<void> register(String alias, String email, String password);
  Future<void> logout();
}
