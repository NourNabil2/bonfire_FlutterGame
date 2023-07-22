// ignore_for_file: camel_case_types

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/decorations/Gate_translate.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';



class PotionLife extends GameDecoration with Sensor<Kinght>
{
  PotionLife({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/potion_life.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));


  @override
  void onContact(GameComponent component) {

    SFX ==true ? FlameAudio.play('power_up.wav') : null ;

    gameRef.player!.addLife(lifePotion);
    removeFromParent();
  }

}

class add_stamina extends GameDecoration with Sensor<Kinght>
{
  add_stamina({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/potion_stamina.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));
  @override
  void onContact(GameComponent component) {

    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    (gameRef.player as Kinght).stamina += 30;
      if ((gameRef.player as Kinght).stamina > 100) {
        (gameRef.player as Kinght).stamina = 100;
    }


    removeFromParent();
  }

}

class PotionFast extends GameDecoration with Sensor<Kinght>
{
bool speedup = false ;
 PotionFast({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/potion_Fast.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));

 @override
  void onContact(GameComponent component) {
   Future.delayed(const Duration(seconds: 3));
    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    (gameRef.player as Kinght).speed += 50 ;
    Future.delayed(const Duration(seconds: 3));
    (gameRef.player as Kinght).speed -= 50 ;

  }

}


class Elec extends GameDecoration with Sensor<Kinght>
{
  Elec({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/elec_P.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));


  @override
  void onContact(GameComponent component) {

    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    CashSaver.SaveData(key: 'PowerE',value: true);
    (gameRef.player as Kinght).PowerE = true;
    gameRef.player!.addLife(lifePotion);
    removeFromParent();
  }

}

class Radio_House extends GameDecoration with TapGesture
{
  Radio_House({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 384), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2.all(20));

  @override
  void onTap() {
    FlameAudio.play('Radio.mp3');

  }





}
bool r =false ;
class safe extends GameDecoration with TapGesture ,ObjectCollision
{
  bool showDialog = false ;
  safe({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(
    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(16, 384), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2.all(20))
  {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(1,1),
            align: Vector2(1,-12),
          ),
        ],
      ),
    );
  }

  @override
  void update(dt) {
    seeComponent(
      gameRef.player!,
      radiusVision: 100,
      observed: (player) {

        if (!showDialog) {
          showDialog = true;
          if (currentMap == 1)
            {
              TalkDialog.show(gameRef.context, [
                 speak(text: 'It\'s my house, was this a nightmare?', isPlayer: true,),
                speak(text: 'I think we are in this life living in a small dream makes no difference',
                    isPlayer: true),

              ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],);
            }
          else if (currentMap == 2)
            {
              TalkDialog.show(gameRef.context, [
                speak(text: 'Ha?! What happened, how?, again?',
                    isPlayer: true),

              ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],);
            }
          else if (currentMap == 4)
          {
            r ?
          {  TalkDialog.show(gameRef.context, [
              speak(text: 'I guess I have to escape from here through the mind gate, I have to gather my strength, ${tower_ON}/3  Luminous stones ',
                  isPlayer: true),

            ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],)
                ,
          }:
            {TalkDialog.show(gameRef.context, [
              speak(text: 'Where am I, forest? \n Wonderful, dream inside a dream, as I think ',
                  isPlayer: true),

            ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],)
            ,
              r = true,removeFromParent()

            };

        }
          else if (currentMap == 6)
          {
             TalkDialog.show(gameRef.context, [
              speak(text: ' WHERE AM I AGAIN WHY DOSE THIS NIGHTMARE NEVER END \n Stop these voices from inside my mind, stop it, stop it, stop it, I can\'t stand it anymore',
                  isPlayer: true),
            ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],);


          }
        }

      },

    );

    super.update(dt);
  }
  @override
  void onTap() {
     if (currentMap == 2)
    {
      (gameRef.player as Kinght).silverKey = true ;
    }


  }





}

class BedRoom_Door extends GameDecoration with ObjectCollision
{
  bool showDialog = false;
  BedRoom_Door({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(
    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(32, 352), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ),


      position: position, size: Vector2(30,30)) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30,20),
            align: Vector2(1,10),
          ),
        ],
      ),
    );
  }
  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          Kinght p = player as Kinght;
          if (p.silverKey == true) {
            p.silverKey = false;
            removeFromParent();
          } else {

            if (!showDialog) {

              showDialog = true;
              if (currentMap == 1 || currentMap == 2 ) {
                TalkDialog.show(gameRef.context, [
                speak(text: 'The door is locked, I have to find the key',
                    isPlayer: true),

              ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space]

              );
              }
              else if (currentMap == 5 )
                {
                  TalkDialog.show(gameRef.context, [
                    speak(text: 'The door is locked, I forget the gold key in my house',
                        isPlayer: true),
                  ], logicalKeyboardKeysToNext: [LogicalKeyboardKey.space]

                  );
                }
            }

          }
        },
        notObserved: () => showDialog = false,
      );
    }
  }

}

class Chest extends GameDecoration with Sensor<Kinght>
{
  Chest({required Vector2 position}): super.withAnimation(size:  Vector2.all(25.0) ,animation: SpriteAnimation.load(
    "items/chest_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: Vector2(16, 16),
    ),
  ) ,position: position );


  @override
  void onContact(GameComponent component) {

   // gameRef.overlayManager.add(LevelWonScreen.id);
  }

}

class Chest_easter extends GameDecoration with Sensor<Kinght>
{
  Chest_easter({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(112, 384), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2(30,30));


  @override
  void onContact(GameComponent component) {
    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    removeFromParent();
  }

}

class Mirror_C_B extends GameDecoration with Sensor<Kinght>
{
  Mirror_C_B({required Vector2 position}): super.withAnimation(size:  Vector2.all(16) ,animation: SpriteAnimation.load(
    "Interface/Mirror_C.png",
    SpriteAnimationData.sequenced(
      amount: 4 ,
      loop:false,
      stepTime: 0.2,
      textureSize: Vector2(32, 32),
    ),
  ) ,position: position );


  @override
  void onContact(GameComponent component) {

 //TODO add Audio


  }

}

class Mirror_C extends GameDecoration
{
  bool finish = false ;
  Mirror_C({required Vector2 position}) : super.withSprite(
      size: Vector2.all(16),
      sprite: Sprite.load('Interface/Mirror_C.png', srcSize: Vector2(32, 32)),
      position: position);
  @override
  void update(double dt) {
    super.update(dt);
      seeComponent(
        radiusVision: 50,
        gameRef.player!,
        observed: (player) {
          if (!finish) {
            finish = true ;
            gameRef.add(Mirror_C_B(position: position));
            FlameAudio.play('Mirror_Crack.mp3',volume: 0.9);
            gameRef.add(AnimatedFollowerObject(
              animation: SpriteAnimation.load(
                unclear,
                SpriteAnimationData.sequenced(
                  amount: 8,
                  stepTime: 0.2,
                  textureSize: Vector2(32, 32),
                ),
              ),
              target: gameRef.player,
              size: Vector2(16, 16),
              positionFromTarget: Vector2(18, -15),
            ),);
            removeFromParent();
          }
        },
      );
  }


}

bool islight = false ;
class Picktorch extends GameDecoration with Sensor<Kinght>
{
  Picktorch({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      "Interface/torch_spritesheet.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(16),
  );
  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.Taketorch = true ;
      CashSaver.SaveData(key: 'torch', value: true);
    }

    removeFromParent();
    // component = component as GreenNinjaPlayer;
    // FlameAudio.play(Globals.fireSound);
    // component.showDamage(_damage);
    // component.removeLife(_damage);
  }
}

class Key_silver extends GameDecoration with Sensor<Kinght>
{
  Key_silver({required Vector2 position , required String keyImage})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      keyImage,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(10),
  ){}

  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.silverKey = true ;
    }
    // FlameAudio.play(Globals.fireSound);
    removeFromParent();

  }
}

class Key_Gold extends GameDecoration with Sensor<Kinght>
{
  Key_Gold({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      GoldrKey,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(10),
  ) {}



  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.goldKey = true ;
      CashSaver.SaveData(key: 'gold', value: true);
    }
    // FlameAudio.play(Globals.fireSound);
    removeFromParent();

  }
}

class Key_red extends GameDecoration with Sensor<Kinght>
{
  Key_red({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      redKey,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(10),
  ) {}



  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.Key_red = true ;
      CashSaver.SaveData(key: 'red', value: true);
    }
    // FlameAudio.play(Globals.fireSound);
    removeFromParent();

  }
}

Vector2 portal = Vector2(2285, 2252);
class Tower_1 extends GameDecoration with TapGesture ,ObjectCollision
{
  Tower_1({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(
    "items/tower.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 0), srcSize: Vector2(48, 70), stepTime: 0.1),


    ],loop: true ),

  ), position: position, size: Vector2.all(48)){
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30,20),
            align: Vector2(1,10),
          ),
        ],
      ),
    );
  }


  @override
  void onTap() {
    if (tower_ON == 2 )
      {
        gameRef.add(Portal(position: portal));
      }
    tower_ON ++ ;
    removeFromParent();
    gameRef.add(Tower_1on(position: position));

  }
}

class Tower_1on  extends GameDecoration {

  Tower_1on({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "items/tower.png",

    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(48, 0), srcSize: Vector2(48, 70), stepTime: 0.1),


    ],loop: true ),

  ),position: position, size: Vector2.all(48));

}

class Tower_2 extends GameDecoration with TapGesture ,ObjectCollision
{
  Tower_2({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "items/tower.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 70), srcSize: Vector2(48, 90), stepTime: 0.1),


    ],loop: false),

  ), position: position, size: Vector2.all(48)){
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30,20),
            align: Vector2(1,10),
          ),
        ],
      ),
    );
  }

  @override
  void onTap() {
    if (tower_ON == 2 )
    {
      gameRef.add(Portal(position: portal));
    }
    else {
      tower_ON ++ ;
    }

    removeFromParent();
    gameRef.add(Tower_2on(position: position));

  }





}

class Tower_2on  extends GameDecoration {

  Tower_2on({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "items/tower.png",

    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(48, 70), srcSize: Vector2(48, 90), stepTime: 0.1),


    ],loop: true ),

  ),position: position, size: Vector2.all(48));

}

class Tower_3 extends GameDecoration with TapGesture ,ObjectCollision
{
  Tower_3({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "items/tower.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 155), srcSize: Vector2(48, 60), stepTime: 0.1),


    ],loop: false),

  ), position: position, size: Vector2.all(48)){
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30,20),
            align: Vector2(1,10),
          ),
        ],
      ),
    );
  }

  @override
  void onTap() {
    if (tower_ON == 2 )
    {
      gameRef.add(Portal(position: portal));
    }
    else {
      tower_ON ++ ;
    }
    removeFromParent();
    gameRef.add(Tower_3on(position: position));
  }





}

class Tower_3on  extends GameDecoration
{

  Tower_3on({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "items/tower.png",

    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(48, 155), srcSize: Vector2(48, 60), stepTime: 0.1),


    ],loop: true ),

  ),position: position, size: Vector2.all(48));

}