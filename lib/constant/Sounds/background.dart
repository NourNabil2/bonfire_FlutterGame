import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'Rain_Noise.wav',
      'SpaceSound.wav',
      'background_home.mp3',
      'background_home2.mp3',
      'forest2.mp3',
      'jail_bg.mp3',
      'bg_Witch.mp3',
      'talks.mp3',
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

  static stop_background_home() {
    return FlameAudio.bgm.play('background_home.wav',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_background_home2() {
    return FlameAudio.bgm.play('background_home2.mp3',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_forest2() {
    return FlameAudio.bgm.play('forest2.mp3',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_jail_bg() {
    return FlameAudio.bgm.play('jail_bg.mp3',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_bg_Witch() {
    return FlameAudio.bgm.play('bg_Witch.mp3',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }

  static stop_Mind() {
    return FlameAudio.bgm.play('talks.mp3',volume: 0.5).then((value) => FlameAudio.bgm.pause());
  }


  static void playBackground_Rain_Noise() async {
    await stopBackgroundSound();
    FlameAudio.bgm.play('Rain_Noise.wav');
  }

  static void playBackground_b2() async {
    await stopBackgroundSound();
    FlameAudio.bgm.play('b2.mp3');
  }

  static void playBackground_background_home() async {
    await stopBackgroundSound();
    FlameAudio.bgm.play( 'background_home.mp3',volume: 0.3);
  }

  static void playBackground_background_home2() async {
    await stopBackgroundSound();
    FlameAudio.bgm.play( 'background_home2.mp3',volume: 0.3);
  }

  static void playBackground_SpaceSound() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('SpaceSound.wav',volume: 0.3);
  }

  static void playBackground_bg_Witch() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('bg_Witch.mp3',volume: 0.3);
  }

  static void playBackground_forest2() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('forest2.mp3',volume: 0.3);
  }

  static void playBackground_jail_bg() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('jail_bg.mp3',volume: 0.35);
  }

  static void playBackground_Mind() async {
   await stopBackgroundSound();
    FlameAudio.bgm.play('talks.mp3',volume: 0.5);
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