
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Screens/Start_Screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'SharedPreferences/Cash_Save.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await CashSaver.init();
   BonfireGame.INTERVAL_UPDATE_CACHE;
   BonfireGame.INTERVAL_UPDATE_ORDER;
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
              bodyLarge:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              bodySmall:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

          ),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
      ),

      home: EasySplashScreen(

        backgroundImage: const AssetImage('assets/images/image_Interface/splash.gif'),
        backgroundColor: Colors.black,
        durationInSeconds: 4,
        navigator: const Start_Screen(), logo: Image.asset('assets/images/image_Interface/blank.png'),
      ),

    );
  }
}
//const GreenNinjaGame(),

