import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Space extends StatelessWidget {

  Space({super.key, required this.width, required this.heigth});
  Space.verticale({required this.heigth, this.width=0});
  Space.horizontale({this.heigth=0, required this.width});


  final double width;
  final double heigth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
    );
  }
}
