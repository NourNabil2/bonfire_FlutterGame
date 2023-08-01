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
          const SizedBox(height: 50,),
          if (dead < 2)
          const Expanded(
            child: Text(
              'You Dead',
              style: TextStyle(
                color: Colors.red,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (dead == 2)
            const Expanded(
              child: Text(
                'You Dead again XD',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (dead == 3)
          const Expanded(
            child: Text(
              'really? It\'s not that difficult',
              style: TextStyle(
                color: Colors.red,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (dead == 4)
          const Expanded(
            child: Text(
              'Hmmm...',
              style: TextStyle(
                color: Colors.red,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (dead > 4)
          const Expanded(
            child: Text(
              'Loser,want to try again?',
              style: TextStyle(
                color: Colors.red,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Expanded(child: MaterialButton(onPressed: () => selectMap(currentMap),
            child: Image.asset('assets/images/image_Interface/replay.png',width:200))),
        ],
      ),
    ),
  );
}
