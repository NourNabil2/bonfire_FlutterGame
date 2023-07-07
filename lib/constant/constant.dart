import 'package:flutter/material.dart';

import '../SharedPreferences/Cash_Save.dart';


// id for typeattack
enum AttackType { melee, range,light }

// numbers
double lifePotion = 20 ;
double Width_Button = 200 ;
double Height_Button = 50 ;

//String Emote
String wonder = 'Emote/emote.png';
String love = 'Emote/emote_love.png';
String dots = 'Emote/emote_dots.png';
String unclear = 'Emote/emote_unclear.png';
String wrong = 'Emote/emote_wrong.png';

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