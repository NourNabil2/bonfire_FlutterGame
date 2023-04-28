import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/TESTing.dart';
import 'package:flutter/material.dart';

import 'GreenNinjaGame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Flame.device.setLandscape();
  // Flame.device.fullScreen();

  runApp( const MyApp() );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      home: const GreenNinjaGame(),
    );
  }
}
//const GreenNinjaGame(),

