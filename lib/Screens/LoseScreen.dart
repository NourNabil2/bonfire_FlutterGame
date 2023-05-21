import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/constant/NameOfMaps.dart';
import 'package:flutter/material.dart';


class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  static const String id = 'game_over';

  @override

  Widget build(BuildContext context) => Material(
    color: Colors.transparent.withOpacity(0.5),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You lose',
            style: TextStyle(
              color: Colors.red,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () => selectMap(MapId.one),
            child: const Text('Play Again?'),
          )
        ],
      ),
    ),
  );
}
