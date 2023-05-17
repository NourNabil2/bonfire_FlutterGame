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
      theme: ThemeData(bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.white) ,badgeTheme: BadgeThemeData(backgroundColor: Colors.grey[800])),
      home:Start_Screen(),

    );
  }
}
//const GreenNinjaGame(),

