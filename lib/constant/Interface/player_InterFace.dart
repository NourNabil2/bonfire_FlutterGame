
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../player/Main_Player.dart';
import '../../player/Main_Player.dart';
import 'Bar_Life.dart';

class KnightInterface extends GameInterface {
  late Sprite torch;
  late Sprite silver_key;
  late Sprite Key_red;
  late Sprite goldKey;
  late Sprite potion_Fast;
  late Sprite Power;
  @override
  Future<void> onLoad() async {
    torch = await Sprite.load('items/torch.png',srcSize: Vector2(10, 10));
    Power = await Sprite.load('items/wave_R.png',srcSize: Vector2(40, 32));
    silver_key = await Sprite.load('items/keys_silver.png',srcSize: Vector2(16, 16));
    Key_red = await Sprite.load('items/Key_red.png',srcSize: Vector2(16, 16));
    goldKey = await Sprite.load('items/keys_gold.png',srcSize: Vector2(16, 16));
    potion_Fast = await Sprite.load('items/potion_Fast.png',srcSize: Vector2(16, 16));
    add(BarLife_Component());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawtorch(canvas);
      _drawkey(canvas);
      _drawRedkey(canvas);
      _drawGoldKey(canvas);
      _drawPower(canvas);
      // _drawSpeedUp(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawtorch(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).Taketorch) {
      torch.renderRect(c ,const Rect.fromLTWH(161, 20, 35, 30));
    }
  }

  void _drawkey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).silverKey) {
      silver_key.renderRect(c ,const Rect.fromLTWH(148, 27, 35, 30));
    }
  }

  void _drawRedkey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).Key_red) {
      Key_red.renderRect(c ,const Rect.fromLTWH(148, 27, 35, 30));
    }
  }

  void _drawGoldKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).goldKey) {
      goldKey.renderRect(c ,const Rect.fromLTWH(120, 27, 35, 30));
    }
  }

  void _drawPower(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).Power) {

      Power.renderRect(c ,const Rect.fromLTWH(90, 27, 35, 30));
    }
  }



  void _drawSpeedUp(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).speed > 100) {
      potion_Fast.renderRect(c ,const Rect.fromLTWH(138, 27, 35, 30));
    }
  }

}