
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../SharedPreferences/Cash_Save.dart';


class SettingPopupCard extends StatefulWidget {
  const SettingPopupCard({Key? key}) : super(key: key);

  @override
  State<SettingPopupCard> createState() => _SettingPopupCardState();
}

class _SettingPopupCardState extends State<SettingPopupCard> {
  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 200),
        child: ClipPath(
          clipper: Tringle1() ,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.7)),
            width: 400,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('BackGround Music',style: style),
                    FlutterSwitch(value: backgroundMusic, onToggle: (value) => setState(() {
                      backgroundMusic == true ? FlameAudio.bgm.pause() : FlameAudio.bgm.resume();
                      backgroundMusic = !backgroundMusic ;
                      CashSaver.SaveData(key: 'BackGround Music', value: backgroundMusic) ;

                    }),
                      toggleColor:        Colors.blueGrey,
                      activeToggleColor:  Colors.grey,
                      activeColor:        Colors.blueGrey,
                      inactiveIcon:   const Icon(CupertinoIcons.speaker_slash_fill),
                      activeIcon:     const Icon(CupertinoIcons.speaker_3_fill),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('SFX Music',style: style),
                    FlutterSwitch(value: SFX, onToggle: (value){
                      setState(() {
                        SFX=!SFX;
                      });
                      CashSaver.SaveData(key: 'SFX', value: SFX);
                    },
                      toggleColor:        Colors.blueGrey,
                      activeToggleColor:  Colors.grey,
                      activeColor:        Colors.blueGrey,
                      inactiveIcon:       const Icon(CupertinoIcons.speaker_slash_fill),
                      activeIcon:         const Icon(CupertinoIcons.speaker_3_fill),),

                  ],
                ),

                ],
              ),
            ),
          ),

        ),
      );
  }
}



