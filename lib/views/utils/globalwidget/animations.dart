

import 'package:flutter/cupertino.dart';

class Animations{
  static fromLeft(Animation<double> animation,Animation<double>secondAnimation,Widget child)
  {
    return SlideTransition(
      position: Tween<Offset>(end:Offset.zero,begin: Offset(1,0.0)).animate(animation),
      child:child);
  }

  static fromRight(Animation<double> animation,Animation<double>secondAnimation,Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end:Offset.zero,begin: Offset(-1,0.0)).animate(animation),
      child:child);
  }

  static fromTop(Animation<double> animation,Animation<double>secondAnimation,Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end:Offset.zero,begin: Offset(0.0,-1.0)).animate(animation),
      child:child);
  }

  static fromBottom(Animation<double> animation,Animation<double>secondAnimation,Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end:Offset.zero,begin: Offset(0.0,1.0)).animate(animation),
      child:child);
  }

  static grow(Animation<double> animation,Animation<double>secondAnimation,Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
            end:1.0,begin: 0.0).animate
          (CurvedAnimation(parent: animation,
            curve: Interval(0.00, 0.50,curve: Curves.bounceInOut))),
      child:child);
  }
}