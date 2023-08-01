import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
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
          if (dead < 2)
          const Text(
            'You Dead',
            style: TextStyle(
              color: Colors.red,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (dead == 2)
            const Text(
              'You Dead again XD',
              style: TextStyle(
                color: Colors.red,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (dead == 3)
          const Text(
            'really? It\'s not that difficult',
            style: TextStyle(
              color: Colors.red,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (dead == 4)
          const Text(
            'Hmmm...',
            style: TextStyle(
              color: Colors.red,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (dead == 4)
          const Text(
            'Loser,want to try again?',
            style: TextStyle(
              color: Colors.red,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 100),
        Expanded(child: ElevatedButton(onPressed: () => selectMap(currentMap),
            child: Image.asset('assets/images/image_Interface/replay.png',width:100))),
        ],
      ),
    ),
  );
}
