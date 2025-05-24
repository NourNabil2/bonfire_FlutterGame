// import 'package:audioplayers/audioplayers.dart';
//
// class Sounds {
//   static final AudioPlayer backgroundPlayer = AudioPlayer();
//   static final AudioPlayer sfxPlayer = AudioPlayer();
//
//   static Future<void> initialize() async {
//     await backgroundPlayer.setReleaseMode(ReleaseMode.loop);
//     await sfxPlayer.setReleaseMode(ReleaseMode.release);
//   }
//
//   /// Toggle background music
//   void toggleBackgroundMusic(bool backgroundMusic) {
//     if (backgroundMusic) {
//       backgroundPlayer.pause();
//     } else {
//       backgroundPlayer.resume();
//     }
//   }
//
//   /// Stop any background sound
//   static Future<void> stopBackgroundSound() async {
//     await backgroundPlayer.stop();
//   }
//
//   /// Background music
//   static Future<void> playBackgroundMusic(String fileName, {double volume = 0.4}) async {
//     await stopBackgroundSound();
//     await backgroundPlayer.setVolume(volume);
//     await backgroundPlayer.setReleaseMode(ReleaseMode.loop);
//     await backgroundPlayer.play(AssetSource('audio/$fileName'));
//   }
//
//   static Future<void> playBackgroundRainNoise() async =>
//       playBackgroundMusic('Rain_Noise.wav');
//
//   static Future<void> playBackgroundB2() async =>
//       playBackgroundMusic('b2.mp3');
//
//   static Future<void> playBackgroundHome() async =>
//       playBackgroundMusic('background_home.mp3');
//
//   static Future<void> playBackgroundHome2() async =>
//       playBackgroundMusic('background_home2.mp3');
//
//   static Future<void> playBackgroundSpaceSound() async =>
//       playBackgroundMusic('SpaceSound.wav');
//
//   static Future<void> playBackgroundWitch() async =>
//       playBackgroundMusic('bg_Witch.mp3');
//
//   static Future<void> playBackgroundForest() async =>
//       playBackgroundMusic('forest2.mp3');
//
//   static Future<void> playBackgroundJail() async =>
//       playBackgroundMusic('jail_bg.mp3');
//
//   static Future<void> playBackgroundMind() async =>
//       playBackgroundMusic('talks.mp3', volume: 0.5);
//
//   /// Pause/Resume background
//   static void pauseBackgroundSound() {
//     backgroundPlayer.pause();
//   }
//
//   static void resumeBackgroundSound() {
//     backgroundPlayer.resume();
//   }
//
//   static void dispose() {
//     backgroundPlayer.dispose();
//     sfxPlayer.dispose();
//   }
//
//   /// Short SFX sounds (if needed)
//   static Future<void> playSFX(String fileName, {double volume = 1.0}) async {
//     final player = AudioPlayer();
//     await player.setVolume(volume);
//     await player.play(AssetSource('audio/$fileName'));
//     player.dispose();
//   }
//
//   /// Example of stopping a sound right after playing (if needed)
//   static Future<void> stopSoundQuickly(String fileName, {double volume = 0.5}) async {
//     final player = AudioPlayer();
//     await player.setVolume(volume);
//     await player.play(AssetSource('audio/$fileName'));
//     await Future.delayed(Duration(milliseconds: 100));
//     await player.stop();
//     player.dispose();
//   }
// }


import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static bool _isBackgroundPlaying = false;

  static Future<void> initialize() async {
    FlameAudio.bgm.initialize();
  }

  /// Toggle background music
  static void toggleBackgroundMusic(bool backgroundMusic) {
    if (backgroundMusic) {
      FlameAudio.bgm.pause();
    } else {
      FlameAudio.bgm.resume();
    }
  }

  /// Stop any background sound
  static Future<void> stopBackgroundSound() async {
    await FlameAudio.bgm.stop();
    _isBackgroundPlaying = false;
  }

  /// Play background music
  static Future<void> playBackgroundMusic(String fileName, {double volume = 0.4}) async {
    if (_isBackgroundPlaying) {
      await stopBackgroundSound();
    }
    await FlameAudio.bgm.play(fileName, volume: volume);
    _isBackgroundPlaying = true;
  }

  static Future<void> playBackgroundRainNoise() async =>
      playBackgroundMusic('Rain_Noise.wav');

  static Future<void> playBackgroundB2() async =>
      playBackgroundMusic('b2.mp3');

  static Future<void> playBackgroundHome() async =>
      playBackgroundMusic('background_home.mp3');

  static Future<void> playBackgroundHome2() async =>
      playBackgroundMusic('background_home2.mp3');

  static Future<void> playBackgroundSpaceSound() async =>
      playBackgroundMusic('SpaceSound.wav');

  static Future<void> playBackgroundWitch() async =>
      playBackgroundMusic('bg_Witch.mp3');

  static Future<void> playBackgroundForest() async =>
      playBackgroundMusic('forest2.mp3');

  static Future<void> playBackgroundJail() async =>
      playBackgroundMusic('jail_bg.mp3');

  static Future<void> playBackgroundMind() async =>
      playBackgroundMusic('talks.mp3', volume: 0.5);

  /// Pause/Resume background music
  static void pauseBackgroundSound() => FlameAudio.bgm.pause();

  static void resumeBackgroundSound() => FlameAudio.bgm.resume();

  /// Play short SFX sounds
  static Future<void> playSFX(String fileName, {double volume = 1.0}) async {
    await FlameAudio.play('$fileName', volume: volume);
  }


  static void handleBackgroundMusic() {
    switch (currentMap) {
      case 0:
        backgroundMusic == true ? Sounds.playBackgroundSpaceSound() : Sounds.stopBackgroundSound();
        break;
      case 1:
        backgroundMusic == true ? Sounds.playBackgroundHome() : Sounds.stopBackgroundSound();
        break;
      case 2:
        backgroundMusic == true ? Sounds.playBackgroundHome2() : Sounds.stopBackgroundSound();
        break;
      case 3:
        backgroundMusic == true ? Sounds.playBackgroundWitch() : Sounds.stopBackgroundSound();
        break;
      case 4:
        backgroundMusic == true ? Sounds.playBackgroundForest() : Sounds.stopBackgroundSound();
        break;
      case 5:
        backgroundMusic == true ? Sounds.playBackgroundJail() : Sounds.stopBackgroundSound();
        break;
      case 6:
        backgroundMusic == true ? Sounds.playBackgroundMind() : Sounds.stopBackgroundSound();
        break;
      default:
        backgroundMusic == true ? Sounds.playBackgroundForest() : Sounds.stopBackgroundSound();
        break;
    }
  }

  /// Example of stopping a sound quickly
  static Future<void> stopSoundQuickly(String fileName, {double volume = 0.5}) async {
    final player = await FlameAudio.play('$fileName', volume: volume);
    await Future.delayed(Duration(milliseconds: 100));
    player.stop();
  }
}
