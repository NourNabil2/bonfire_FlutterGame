import 'package:admob_flutter/admob_flutter.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../MainGame.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';
int selected =0;
class purchases extends StatefulWidget {
  const purchases({Key? key}) : super(key: key);

  @override
  State<purchases> createState() => _purchasesState();


}

class _purchasesState extends State<purchases> {

int balance_1 = CashSaver.getData(key: 'balance_1')?? 0;
int balance_2 =CashSaver.getData(key: 'balance_2')?? 0;

  @override
  void initState() {
    rewardAd = AdmobReward(
      adUnitId: adsManager.RewardedAds_UnitID,
      listener: (AdmobAdEvent event, Map) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );
    rewardAd.load();
    selected;
    super.initState();
  }

  @override

  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey.withOpacity(0.7),
    floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pop(context),backgroundColor: Colors.grey, child: const Icon(Icons.home,color: Colors.blueGrey,) ),

    body: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children:[
          MaterialButton(

            onPressed: () {
              setState(() {
                selected = 0 ;
              });
            },
            child: Card(
                color:  selected == 0 ?Colors.grey  : Colors.grey.withOpacity(0.6),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('DEFUALT Joystike'),
                      ),
                      Icon(Icons.check,color: Colors.blueGrey,size: 50),


                    ])),
          ),
          const SizedBox(width: 10,),
          MaterialButton(
            onPressed: () {
              balance_1 ==6 ?
              setState(() {
                selected = 1 ;
              }): null;

            },
            child: Card(
                color:  selected == 1 ?Colors.grey  : Colors.grey.withOpacity(0.6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Image.asset('assets/images/Player/Joystick/Peview1.png',width: 200),
                      balance_1 < 6 ?  IconButton(onPressed: () async {
                        if (await rewardAd.isLoaded) {
                          setState(() {
                            rewardAd.show();
                            CashSaver.SaveData(key: 'balance_1', value: balance_1++);
                          });
                        }
                        else
                          {
                            Alert(context: context, title: "No Ads,try again later").show();
                          }
                      }, icon: const Icon(Icons.ondemand_video,color: Colors.blueGrey,size: 50) ) :
                      const Icon(Icons.check,color: Colors.blueGrey,size: 50),
                      const SizedBox(height: 10,),
                      Text('   $balance_1/6'),

                    ])),
          ),
          const SizedBox(width: 10,),
          MaterialButton(

            onPressed: () {
              balance_2 == 11 ?
              setState(() {
                selected = 2 ;
              }):null;
            },
            child: Card(
                color:  selected == 2 ?Colors.grey  : Colors.grey.withOpacity(0.6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/images/Player/Joystick/Peview0.png',width: 200),
                      ),
                      balance_2 < 11 ?  IconButton(onPressed: () async {
                        if (await rewardAd.isLoaded) {
                          setState(() {
                            CashSaver.SaveData(key: 'balance_2', value: balance_2++);
                          rewardAd.show();

                        });
                        }
                        else
                          {
                            Alert(context: context, title: "No Ads").show();
                          }


                        }, icon: const Icon(Icons.ondemand_video,color: Colors.blueGrey,size: 50,) ) :
                      const Icon(Icons.check,color: Colors.blueGrey,size: 50),
                      SizedBox(height: 10,),
                      Text('   $balance_2/11'),

                    ])),
          ),


        ]
    ),
  );
}
