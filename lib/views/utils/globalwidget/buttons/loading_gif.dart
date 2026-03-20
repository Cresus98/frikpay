import 'package:flutter/material.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../constantes.dart' show white;



class LoadingGif extends StatelessWidget {
  const LoadingGif({
    this.colours = const [white],
    this.effect = Indicator.ballPulse,
    this.height = 28.0,
    this.width = 128.0,
    super.key,
  });

  final List<Color> colours;
  final Indicator effect;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: context.dx(width),
      height: context.dy(height),
      child: LoadingIndicator(indicatorType: effect, colors: colours),
    );
  }
}