
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
 bool isPressed= false;
Offset distance = Offset(4, 4);
double blurRadius = 8.0;
Widget Button (
{
  required double width ,
  required double height ,
  required double radius,
  required Color ColorOfButton,
  required String text,
  required Function ,
  required bool border,
  required bool isboxShadow ,

}
)=>GestureDetector(
  onTap: Function,
  child:  AnimatedContainer(

    duration: Duration(milliseconds: 100),

  width: width,

  height: height,

  decoration: BoxDecoration( border:border ? Border.all(width: 2) : null ,borderRadius: BorderRadius.circular(radius),color: ColorOfButton , boxShadow:isboxShadow?isPressed ?[] :[



    BoxShadow(

      blurRadius: blurRadius,

      offset: -distance,

      color: Colors.white24,

      spreadRadius: 1,

      inset: isPressed

    ),
    BoxShadow(

        blurRadius: blurRadius,

        offset: distance,

        color: Colors.black87,

        inset: isPressed

    ),



  ]:null),

    child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),)),



  ),
);