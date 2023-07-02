import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';

class BarLife_Component extends InterfaceComponent {
  double padding = 20;
  double widthBar = 90;
  double strokeWidth = 12;
  double maxLife = 0;
  double life = 0;
  double maxStamina = 100;
  double stamina = 0;
  BarLife_Component()
      : super(
    id: 1,
    position: Vector2(85, 15),
    spriteUnselected: Sprite.load('Interface/player_Interface/health_ui.png'),
    size: Vector2(120, 40),
  );

  @override
  void update(double t) {
    if (gameRef.player != null) {
      life = gameRef.player!.life;
      maxLife = gameRef.player!.maxLife;
      if (gameRef.player is Kinght) {
        stamina = (gameRef.player as Kinght).stamina;
      }
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
      _drawStamina(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 113;
    double yBar = 26.5;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  void _drawStamina(Canvas canvas) {
    double xBar = 113;
    double yBar = (width - 11) / 3;

    double currentBarStamina = (stamina * widthBar) / maxStamina;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarStamina, yBar),
        Paint()
          ..color = Colors.orangeAccent
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}