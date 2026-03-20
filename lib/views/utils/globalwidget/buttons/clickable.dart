import 'package:flutter/material.dart';

import '../../constantes.dart' show transparent;



class Clickable extends StatelessWidget {
  const Clickable({
    this.splashColor = transparent,
    this.highlightColor = transparent,
    required this.onClick,
    required this.child,
    super.key,
  });

  final GestureTapCallback onClick;

  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: highlightColor,
      splashColor: splashColor,
      onTap: onClick,
      child: child,
    );
  }
}