import 'package:bonfire_flutter_game/GreenNinjaGame.dart';
import 'package:bonfire_flutter_game/constant/Maps.dart';
import 'package:flutter/material.dart';


class LevelWonScreen extends StatelessWidget {
  const LevelWonScreen({Key? key}) : super(key: key);

  static const String id = 'level_won';

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent.withOpacity(0.5),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You won, Green Ninja!',
            style: TextStyle(
              color: Colors.green,
              fontSize: 100,
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
