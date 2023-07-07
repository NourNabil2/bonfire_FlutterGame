
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../player/Main_Player.dart';
import '../../player/Main_Player.dart';
import 'Bar_Life.dart';

class KnightInterface extends GameInterface {
  late Sprite torch;
  late Sprite silver_key;
  @override
  Future<void> onLoad() async {
    torch = await Sprite.load('items/torch.png',srcSize: Vector2(10, 10));
    silver_key = await Sprite.load('items/keys_silver.png',srcSize: Vector2(16, 16));
    add(BarLife_Component());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawtorch(canvas);
      _drawkey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawtorch(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).Taketorch) {
      torch.renderRect(c ,Rect.fromLTWH(161, 20, 35, 30));
    }
  }

  void _drawkey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).silverKey) {
      silver_key.renderRect(c ,Rect.fromLTWH(148, 27, 35, 30));
    }
  }

}