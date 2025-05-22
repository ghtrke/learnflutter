abstract class SettingsPersistence {
  Future<bool> getMuted({required bool defaultValue});
  Future<void> saveMuted(bool muted);
  Future<String> getPlayerName({required String defaultValue});
  Future<void> savePlayerName(String name);
}