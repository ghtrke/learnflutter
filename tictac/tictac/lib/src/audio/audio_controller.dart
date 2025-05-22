import 'package:audioplayers/audioplayers.dart';
import 'package:tictac/src/settings/settings.dart';

class AudioController {
  final AudioPlayer _musicPlayer;
  final AudioPlayer _sfxPlayer;
  SettingsController? _settings;

  AudioController() : _musicPlayer = AudioPlayer(playerId: 'musicPlayer'), _sfxPlayer = AudioPlayer(playerId: 'sfxPlayer');

  Future<void> _startMusic() async {
    await _musicPlayer.play(AssetSource('music/1.mp3'));
  }

  Future<void> _stopMusic() async {
    await _musicPlayer.stop();
  }

  Future<void> _startSfx() async {
    await _sfxPlayer.play(AssetSource('sfx/ws1.mp3'));
  }

  Future<void> _stopSfx() async {
    await _sfxPlayer.stop();
  }

  void _handleMuted() {
    if (_settings!.muted.value) {
      if(_settings!.musicEnabled.value) {
        _stopMusic();
      }
      if(_settings!.sfxEnabled.value) {
        _stopSfx();
      }
    } else {
      if(_settings!.sfxEnabled.value) {
        _startSfx();
      }
      if(_settings!.musicEnabled.value) {
        _startMusic();
      }
    }
  }

  void _handleMusic() {
    if (! _settings!.muted.value) {
      if(_settings!.musicEnabled.value) {
        _startMusic();
      } else {
        _stopMusic();
      }
    }
  }

  void _handleSfx() {
    if(_settings!.muted.value) {
      if(! _settings!.sfxEnabled.value) {
        _startSfx();
      } else {
        _stopSfx();
      }
    }
  }

  void attachSettings(SettingsController settings) {
    _settings = settings;
    settings.muted.addListener(_handleMuted);
    settings.musicEnabled.addListener(_handleMusic);
    settings.sfxEnabled.addListener(_handleSfx);
  }

  void dispose() {
    _settings?.muted.removeListener(_handleMuted);
    _settings?.musicEnabled.removeListener(_handleMusic);
    _settings?.sfxEnabled.removeListener(_handleSfx);
    _settings = null;
    _musicPlayer.dispose();
  }

  void initialize() {

  }
}