abstract class InternetManager {
  Future<bool> checkConnection();
  Future<String?> getNetworkType();
}
