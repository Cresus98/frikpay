import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Space extends StatelessWidget {

  const Space({super.key, required this.width, required this.heigth});
  const Space.verticale({super.key, required this.heigth, this.width=0});
  const Space.horizontale({super.key, this.heigth=0, required this.width});


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
