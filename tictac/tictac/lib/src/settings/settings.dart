import 'package:flutter/widgets.dart';
import 'package:tictac/src/settings/persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;
  ValueNotifier<bool> muted = ValueNotifier(false);
  ValueNotifier<bool> sfxEnabled = ValueNotifier(false);
  ValueNotifier<bool> musicEnabled = ValueNotifier(false);
  ValueNotifier<String> playerName = ValueNotifier("Player");

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence.getMuted(defaultValue: false).then((value) {
        muted.value = value;
      }),
    ]);
  }

  Future<void> toggleMuted() async {
    muted.value = !muted.value;
    await _persistence.saveMuted(muted.value);
  }

  Future<void> toggleSfxEnabled() async {
    sfxEnabled.value = !sfxEnabled.value;
    await _persistence.saveMuted(sfxEnabled.value);
  }

  Future<void> toggleMusicEnabled() async {
    musicEnabled.value = !musicEnabled.value;
    await _persistence.saveMuted(musicEnabled.value);
  }

  Future<void> setPlayerName(String name) async {
    playerName.value = name;
    await _persistence.savePlayerName(name);
  }
}