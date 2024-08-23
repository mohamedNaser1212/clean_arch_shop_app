abstract class AuthenticationLocalDataSource {
  Future<void> saveToken(String token);
  Future<String> getToken();
  Future<void> removeToken();
}
