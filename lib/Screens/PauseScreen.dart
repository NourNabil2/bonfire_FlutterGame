import 'package:bonfire/base/bonfire_game.dart';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Screens/Start_Screen.dart';
import 'package:bonfire_flutter_game/Screens/settingScreen.dart';
import 'package:bonfire_flutter_game/constant/Hero_Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';

class PauseScreen extends StatelessWidget {
  final BonfireGame game ;
  const PauseScreen({Key? key,required this.game}) : super(key: key);
  static const String id = 'PauseScreen';

  @override

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pause',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 80,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none
            ),
          ),
          const SizedBox(height: 100),
          MaterialButton(
              onPressed: () {
                game.overlayManager.remove(PauseScreen.id);
                game.gameController!.gameRef.resumeEngine();
              },
              child: TextMenu(title: 'Resume')
          ),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    HeroDialogRoute(builder: (context) {
                      return SettingPopupCard();
                    }
                    ));
              },

              child: TextMenu(title: 'Settings')
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Start_Screen(),), (route) => false);
            },
            child: TextMenu(title: 'Main Menu')
          ),
        ],
      ),
    );
  }
}
