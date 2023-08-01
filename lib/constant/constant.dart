import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/talk/say.dart';
import 'package:flutter/material.dart';
import '../SharedPreferences/Cash_Save.dart';
import '../player/Main_Player.dart';


// id for typeattack
enum AttackType { Swrd, range,PowerSwrd,light,Elec,Punch }

// numbers
double lifePotion = 20 ;
double Width_Button = 200 ;
double Height_Button = 50 ;
int tower_ON = 0 ;
int dead = 0;
//talk

Say speak({required String text , required bool isPlayer , spritesheet })=> Say(
  text: [TextSpan(text: text),],
  person: SizedBox(height: 100,width: 100,child: isPlayer ? PlayerSpriteSheet2.idleRight.asWidget() : spritesheet ,),
  personSayDirection: isPlayer ? PersonSayDirection.LEFT :PersonSayDirection.RIGHT ,
);

//String Emote
String wonder = 'Emote/emote.png';
String love = 'Emote/emote_love.png';
String dots = 'Emote/emote_dots.png';
String unclear = 'Emote/emote_unclear.png';
String wrong = 'Emote/emote_wrong.png';

//String Key
String SilverKey = 'items/keys_silver.png';
String GoldrKey = 'items/keys_gold.png';
String redKey = 'items/Key_red.png';

//Music
bool backgroundMusic =  CashSaver.getData(key: 'BackGround Music') ?? true ;
bool SFX        =  CashSaver.getData(key: 'SFX') ?? true;

//save Maps
int Map =  CashSaver.getData(key: 'Current_Map') ?? 0 ;


// themes
ThemeData light = ThemeData.light().copyWith(
  primaryColor: Colors.green,
);

ThemeData dark = ThemeData.dark().copyWith(
  primaryColor: Colors.blueGrey,
);

//style
TextStyle style =const TextStyle(color: Colors.black ,decoration: TextDecoration.none,overflow: TextOverflow.fade,fontSize: 18);
TextStyle style1 = TextStyle(color: Colors.grey[900] ,decoration: TextDecoration.none,overflow: TextOverflow.fade,fontSize: 16);


Text TextMenu({required String title}) => Text(
    title,
  style: const TextStyle( fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.blueGrey ,
      shadows: [ BoxShadow(color: Colors.black54 ,blurRadius: 8.0,offset: Offset(4, 4))])

);

 //Tringle style
class Tringle1 extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width/20 ,0 );
    path.lineTo(size.width/2.5,size.height );
    path.lineTo(size.width,size.height );
    path.lineTo(size.width,0 );


    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}


class Tringle extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width/2,0 );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}


// story board
class boardingModel {

  late final String image;
  late final String title;
  late final String body;

  boardingModel({
    required this.image,
    required this.title,
    required this.body,
  });

}
List<boardingModel> boarding = [

  boardingModel(image: 'assets/images/6.jpg', title: 'on board 1 shop app', body: 'body shop app'),
  boardingModel(image: 'assets/images/6.jpg', title: 'on board 2 shop app', body: 'body shop app'),
  boardingModel(image: 'assets/images/6.jpg', title: 'on board 3 shop app', body: 'body shop app'),

];