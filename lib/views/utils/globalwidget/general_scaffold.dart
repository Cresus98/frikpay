import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/views/utils/extensions.dart';

class GeneralScaffold extends ConsumerWidget {
  final Widget content;
  final Color ? backgroundColor;
  final GlobalKey<ScaffoldState> ? scaffoldKey;
  const GeneralScaffold({super.key,required this.content,this.scaffoldKey,this.backgroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      //SafeArea(

      //  child:
        Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
            SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: content,
            ),
              ],
            ),
          ),
        )
    //)
    ;
  }
}

