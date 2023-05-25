
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/Screens/settingScreen.dart';
import 'package:bonfire_flutter_game/constant/Buttons.dart';
import 'package:bonfire_flutter_game/constant/Hero_Dialog.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/services.dart';

class Start_Screen extends StatefulWidget {
  const Start_Screen({Key? key}) : super(key: key);

  @override
  State<Start_Screen> createState() => _Start_ScreenState();
}


class _Start_ScreenState extends State<Start_Screen> {

  @override
  void initState() {
    isPressed;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children:
          [
          const Image(image: AssetImage('assets/images/image_Interface/BG.gif'),width: double.infinity,fit: BoxFit.fill),
            ClipPath(
              clipper:Tringle() ,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.7)),
                width: 400,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Button(width: 100,height: 100,isboxShadow: true,border: true,radius: 50, ColorOfButton: Colors.red, text: 'start', Function: () async{
                        setState(() {
                          isPressed=!isPressed;
                        });
                        await Future.delayed(Duration(milliseconds: 300));
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Just_Like_YouGame(),), (route) => false);
                        setState(() {
                          isPressed=!isPressed;
                        });
                      }),
                     const SizedBox(height: 40,),
                      Button(width: Width_Button,height: Height_Button,isboxShadow: false,border: false,radius: 10, ColorOfButton: Colors.blueGrey, text: 'Settings',
                          Function: () async {
                         await  Navigator.of(context).push(
                                HeroDialogRoute(builder: (context) {
                                  return SettingPopupCard();
                                }
                                )
                            );
                          }
    ),
                      const SizedBox(height: 15,),
                      Button(width: Width_Button+50,height: Height_Button,isboxShadow: false,border: false,radius: 10, ColorOfButton: Colors.blueGrey, text: 'About Us', Function: (){}),
                      const SizedBox(height: 15,),
                      Button(width: Width_Button+100,height: Height_Button,isboxShadow: false,border: false,radius: 10, ColorOfButton: Colors.blueGrey, text: 'Exit', Function: (){
                        SystemNavigator.pop();
                      }),








                    ],
                  ),
                ),
              ),

            ),
          ]
        ),
    );
  }
}


