import 'package:flutter/material.dart';
import 'package:fripay/views/utils/extensions.dart';

import '../../constantes.dart' show appDefaultRadius;




class BigButton extends StatelessWidget {
  const BigButton({
    required this.labelText,
    required this.onPressed,
    this.isEnabled = true,
    this.isBusy = false,
    this.circle=appDefaultRadius,
    this.size=16.0,
    this.color=Colors.white,
    this.fixedSized,
    this.textStyle,
    this.isWidgetNext=false,
    this.widgetNext,
    this.widgetPrevious,
    this.isWidgetPrevious=false,
    this.borderSide=false,
    this.buttonSide,
    this.isRow=false,
    this.isWidget=false,
    this.widget,
    this.fontWeight,
    this.textColor,this.backgroundClr,
    this.paddingV,
    this.simple=false,
    this.elevation,
    this.row_widget,
    this.center=true,
    super.key,

  });


  final VoidCallback onPressed;
  final String labelText;

  final bool isEnabled;
  final bool isBusy;
  final double circle;
  final double size;
  final Color color;
  final Color ?backgroundClr;
  final Color? textColor;
  final Size ? fixedSized;
  final bool borderSide;
  final bool  isWidgetNext;
  final bool  isWidget;
  final bool   isRow;
  final bool  isWidgetPrevious;
  final TextStyle ? textStyle;
  final Widget ? widgetNext;
  final Widget ? widgetPrevious;
  final Widget ? widget;
  final FontWeight? fontWeight;
  final BorderSide ? buttonSide;
  final double ? paddingV;
  final double ? elevation;
  final bool  simple;
  final bool  center;
 final Widget? row_widget;


  @override
  Widget build(BuildContext context) {


    final scheme = Theme.of(context).colorScheme;
    final backgroundColour = backgroundClr ?? scheme.primary;

    return ElevatedButton(
     // onPressed: (isEnabled && !isBusy) ? onPressed : () {},
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: fixedSized,
        shape:
        buttonSide==null?
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circle),
        ):
        RoundedRectangleBorder(
          side: buttonSide!,
          borderRadius: BorderRadius.circular(circle),
        ),
        backgroundColor: backgroundColour,
        elevation: elevation??1.5,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingV?? 0),
        child:
            !simple?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelText,
              style: context.textStyle
              (
                  fontWeight: fontWeight?? FontWeight.w700,
                  colour: color,
                  fontSize: size
              ),
            ),
          ],
        ):isRow?
            Row(
              mainAxisAlignment: !center? MainAxisAlignment.start:MainAxisAlignment.center,
              children: [
                row_widget?? SizedBox(),
                Text(
                  labelText,
                  style: context.textStyle
                    (
                      fontWeight: fontWeight?? FontWeight.w700,
                      colour: color,
                      fontSize: size
                  ),
                ),
              ],
            ):
            Text(
              labelText,
              style: context.textStyle
                (
                  fontWeight: fontWeight?? FontWeight.w700,
                  colour: color,
                  fontSize: size
              ),
            ),
      ),
    );
  }

}