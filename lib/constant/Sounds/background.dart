import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'Rain_Noise.wav',
      'SpaceSound.wav',
    ]);
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static stop_Space() {
    return FlameAudio.bgm.play('SpaceSound.wav',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_Rain_Noise() {
    return FlameAudio.bgm.play('Rain_Noise.wav',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static void playBackground_Rain_Noise() async {
    await stopBackgroundSound();
    FlameAudio.bgm.play('Rain_Noise.wav');
  }

  static void playBackground_SpaceSound() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('SpaceSound.wav',volume: 0.5);
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}