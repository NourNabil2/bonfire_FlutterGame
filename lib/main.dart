import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Screens/Start_Screen.dart';
import 'package:flutter/material.dart';
import 'MainGame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Flame.device.setLandscape();
   Flame.device.fullScreen();

  runApp( const MyApp() );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Just Like You',
      theme: ThemeData(
          fontFamily: 'Playfair',
          primaryColor: Colors.blueGrey,
          textTheme:const TextTheme(
              titleLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              bodySmall: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

          ),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
      ),
      home:Start_Screen(),

    );
  }
}
//const GreenNinjaGame(),

