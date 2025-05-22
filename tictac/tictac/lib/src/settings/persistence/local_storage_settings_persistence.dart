import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictac/src/settings/persistence/settings_persistence.dart';

class LocalStorageSettingsPersistence implements SettingsPersistence{
  // TODO: SharedPreferences vs SharedPreferencesAsync vs SharedPreferencesCache
  final Future<SharedPreferences> instanceFuture = SharedPreferences.getInstance(); 
  @override
  Future<bool> getMuted({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('muted') ?? defaultValue;
  }

  @override
  Future<void> saveMuted(bool muted) async {
    final prefs = await instanceFuture;
    await prefs.setBool('muted', muted);
  }
  
  @override
  Future<String> getPlayerName({required String defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getString('playerName') ?? defaultValue;
  }
  
  @override
  Future<void> savePlayerName(String name) async {
    final prefs = await instanceFuture;
    await prefs.setString('playerName', name);
  }

}