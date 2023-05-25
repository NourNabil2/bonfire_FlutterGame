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
                FloatingActionButton(onPressed: () {
                  if ( last )
                  {
                    Navigator.pop(context);
                  }
                  else
                  {
                    boarderController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
                  }

                }, splashColor: Colors.purple[900],child: Icon(Icons.arrow_forward_ios , color: Colors.white), ),


              ],)
          ],
        ),
      ),

    );

  }
}
Widget onBoarding(boardingModel model) => Column(
  children: [
    Expanded(child: Image(image: AssetImage('${model.image}'))),
    SizedBox(height: 15,),
    Text('${model.title}' , style: TextStyle(fontSize: 24, color: CupertinoColors.black , ),),
    SizedBox(height: 5,),
    Text('${model.body}' , style: TextStyle(fontSize: 14, color: CupertinoColors.black , ),),
  ],
) ;