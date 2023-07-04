
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../player/Main_Player.dart';
import '../../player/Main_Player.dart';
import 'Bar_Life.dart';

class KnightInterface extends GameInterface {
  late Sprite torch;
  @override
  Future<void> onLoad() async {
    torch = await Sprite.load('items/torch.png',srcSize: Vector2(10, 10));
    add(BarLife_Component());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawtorch(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawtorch(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Kinght).Taketorch) {
      torch.renderRect(c ,Rect.fromLTWH(150, 20, 35, 30));
    }
  }

}