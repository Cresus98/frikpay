import 'package:flutter/material.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart' show Clickable;
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../../constantes.dart' show white;





class ButtonBack extends StatelessWidget {
  final Color iconColor;
  final backgroundColor;
  final Function() ? onclick;
  const ButtonBack({super.key, this.iconColor=ColorName.webBlack,this.backgroundColor=white,this.onclick});

  @override
  Widget build(BuildContext context) {
    return  Clickable(
        onClick: onclick?? context.pop,
        child: Container(
          padding: const EdgeInsets.only(top: 2,left: 5,right: 5,bottom:2),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Icon(Icons.arrow_back,color:
            iconColor,)
        ));
  }
}
