
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/material.dart';

class SettingPopupCard extends StatelessWidget {
  const SettingPopupCard({Key? key}) : super(key: key);
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('BackGround Music',style: style),
                    TextButton(onPressed: () {}, child: Text('off',style: style,)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('SFX Music',style: style),
                    TextButton(onPressed: () {}, child: Text('off',style: style,)),
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



