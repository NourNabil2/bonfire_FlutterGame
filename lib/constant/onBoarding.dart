import 'package:bonfire_flutter_game/Screens/Start_Screen.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var boarderController = PageController();
final Color kDarkBlueColor = Color(0xFF053149);

class OnBoarding extends StatefulWidget {


  OnBoarding({required this.Story});
  final List<boardingModel> Story;
  @override
  State<OnBoarding> createState() => _OnBoardingState(Story: Story);

}

class _OnBoardingState extends State<OnBoarding> {
  List<boardingModel> Story;


  @override

  void initState() {

    // TODO: implement initState
    super.initState();
  }
  _OnBoardingState({required this.Story});
  // void skipTOlogin() {
  //
  //   CashSaver.SaveData(key: 'OnBoarding', value: true ).then(
  //           (value) {
  //         if (value) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login(),), (Route<dynamic>route) => false);
  //       }
  //
  //   );
  //
  // }

  var last = false ;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black38,
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => onBoarding(Story[index]),
                onPageChanged: (value) {
                  if (value == Story.length -1)
                  {
                    setState(() {
                      last = true;
                    });

                  }
                },
                allowImplicitScrolling: true,
                scrollDirection: Axis.horizontal,
                scrollBehavior:const MaterialScrollBehavior(),
                physics:const BouncingScrollPhysics(),
                controller: boarderController,
                itemCount: Story.length,
              ),
            ),
            Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                  if ( last )
                  {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Start_Screen(),), (route) => false);
                  }
                  else
                  {
                    boarderController.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
                  }

                },child: Image.asset('assets/images/image_Interface/button.png'), ),


              ],)
          ],
        ),
      ),

    );

  }
}
Widget onBoarding(boardingModel model) => Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Column(
crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Expanded(child: Text('${model.title1}', style: const TextStyle(fontSize: 70, color: CupertinoColors.white , ),)),

      const SizedBox(height: 15),

      Expanded(child: Text('${model.title}', style: const TextStyle(fontSize: 22, color: CupertinoColors.white , ),)),

      const SizedBox(height: 5),

      Expanded(child: Text('${model.body}', style: const TextStyle(fontSize: 14, color: CupertinoColors.white , ),)),

    ],

  ),
) ;