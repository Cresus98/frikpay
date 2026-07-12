import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/buttons/bigbutton.dart';
import 'package:fripay/views/utils/globalwidget/space.dart' show Space;
import 'package:go_router/go_router.dart';

import '../../../controllers/authview/authview.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import 'animations.dart' show Animations;

openDialogBox(BuildContext context,String title,  Widget content) {
  return showGeneralDialog(
    barrierLabel: '',
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        Animations.grow(animation, secondaryAnimation, child),
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => content,
  );
}

// a cause de loading mis dans le riverpod au fait les action du loading fera en fonction du model view

enum AlertLoadingCase { Auth, WalletOptions,Cartes,Banques }

class CustomAlertDialog extends ConsumerStatefulWidget {
  final AlertLoadingCase alertLoadingCase;
  final bool with_cancel;
  const CustomAlertDialog(
      {super.key,
      this.alertLoadingCase = AlertLoadingCase.Auth,
      this.with_cancel = false});

  @override
  ConsumerState<CustomAlertDialog> createState() => _CustomAlertDialogState();
}


class _CustomAlertDialogState extends ConsumerState<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;

  bool loading = false, succes = false;
  String msg = "";
  String account = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

/*
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSuccess = true;
      });
      _controller.forward();
    });
 */
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alertLoadingCase == AlertLoadingCase.Auth) {
      loading =
          ref.watch(authviewProvider.select((element) => element.loading));
      succes = ref.watch(authviewProvider.select((element) => element.succes));
      msg = ref.watch(authviewProvider.select((element) => element.message));
    }
    if (!loading) {
      _controller.forward();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: loading
                  ? Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 45,
                      child: const CircularProgressIndicator(
                        color: ColorName.bleu,
                        backgroundColor: ColorName.webwhite,
                      ),
                    )
                  : succes
                      ? ScaleTransition(
                          scale: _iconScale,
                          child:Assets.icones.succes.svg(
                            width: 65,height: 65
                          )
                        )
                      : ScaleTransition(
                          scale: _iconScale,
                          child:Assets.icones.error.svg(
                              width: 65,height: 65
                          )
                          /*
                          const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 100,
                          ),
                       */
                        ),
            ),
            Space.verticale(heigth: 5),
            if(!loading)
            Text(succes? "Succes":"Echec",
                textAlign: TextAlign.center,
                style: context.textStyle(
                    colour: succes ? const Color(0xFF2196F3) : ColorName.red,
                    fontWeight: FontWeight.w800, fontSize: 15)),
            Space.verticale(heigth: 10),
            Text(msg,
                textAlign: TextAlign.center,
                style: context.textStyle(
                    fontWeight: FontWeight.w800, fontSize: 15))
          ],
        ),
      ),
      actions: [
        if (!loading && !succes &&
            (widget.alertLoadingCase == AlertLoadingCase.Auth
                || widget.alertLoadingCase==AlertLoadingCase.Cartes
                || widget.alertLoadingCase==AlertLoadingCase.Banques
            ))
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),

        if (!loading &&
            succes &&
            widget.alertLoadingCase == AlertLoadingCase.WalletOptions &&
            widget.with_cancel)
          TextButton(
            onPressed: () {
              context.pop();
              //context.pushNamed(RoutesNames.Code,extra: account);
            },
            child: const Text('OK'),
          ),
        if (!loading &&
            succes &&
            widget.alertLoadingCase == AlertLoadingCase.WalletOptions &&
            widget.with_cancel)
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Annuler'),
          ),
        if (!loading &&
            !succes &&
            widget.alertLoadingCase == AlertLoadingCase.WalletOptions)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
      ],

    );
  }
}



class CustomAlertDialogNew extends ConsumerStatefulWidget {
  final AlertLoadingCase alertLoadingCase;
  final bool with_cancel;
  const CustomAlertDialogNew(
      {super.key,
        this.alertLoadingCase = AlertLoadingCase.Auth,
        this.with_cancel = false});

  @override
  ConsumerState<CustomAlertDialogNew> createState() => _CustomAlertDialogNewState();
}

class _CustomAlertDialogNewState extends ConsumerState<CustomAlertDialogNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;


  bool loading = false, succes = false;
  String msg = "";
  String account = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alertLoadingCase == AlertLoadingCase.Auth) {
      loading =
          ref.watch(authviewProvider.select((element) => element.loading));
      succes = ref.watch(authviewProvider.select((element) => element.succes));
      msg = ref.watch(authviewProvider.select((element) => element.message));
    }

    if (!loading) {
      _controller.forward();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: loading
                  ? Container(
                alignment: Alignment.center,
                height: 45,
                width: 45,
                child: const CircularProgressIndicator(
                  color: ColorName.bleu,
                  backgroundColor: ColorName.webwhite,
                ),
              )
                  : succes
                  ? ScaleTransition(
                  scale: _iconScale,
                  child:Assets.icones.succes.svg(
                      width: 65,height: 65
                  )

              )
                  : ScaleTransition(
                  scale: _iconScale,
                  child:Assets.icones.error.svg(
                      width: 65,height: 65
                  )
              ),
            ),
            Space.verticale(heigth: 5),
            if(!loading)
            Text(succes? "Succes":"Echec",
                textAlign: TextAlign.center,
                style: context.textStyle(
                  colour: succes ? const Color(0xFF0F74A9) : ColorName.red,
                    fontWeight: FontWeight.w800, fontSize: 15)),
            Space.verticale(heigth: 10),
            //Text("Connexion en cours ....")
            Text(msg,
                textAlign: TextAlign.center,
                style: context.textStyle(
                    fontWeight: FontWeight.w800, fontSize: 15)),
            Space.verticale(heigth: 10),
            if(!loading && succes)
            BigButton(labelText: "Continuer ",
              backgroundClr: ColorName.bleu,
              color: ColorName.webwhite,
              onPressed:() {
                Navigator.of(context).pop();

            },),
            if(!loading && !succes)
            BigButton(labelText: " OK ",
              fixedSized: const Size(100, 30),
              backgroundClr: ColorName.bleu,
              color: ColorName.webwhite,
              onPressed:() {
                Navigator.of(context).pop();
            },),
          ],
        ),
      ),

    );
  }
}

class CustomLoadingData extends ConsumerStatefulWidget {
  final AlertLoadingCase alertLoadingCase;
  final bool with_cancel;
  const CustomLoadingData(
      {super.key,
        this.alertLoadingCase = AlertLoadingCase.Auth,
        this.with_cancel = false});

  @override
  ConsumerState<CustomLoadingData> createState() => _CustomLoadingDataState();
}

class _CustomLoadingDataState extends ConsumerState<CustomLoadingData>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;

  bool loading = false, succes = false;
 String msg="";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alertLoadingCase == AlertLoadingCase.Auth) {
      loading =
          ref.watch(authviewProvider.select((element) => element.loading));
      succes = ref.watch(authviewProvider.select((element) => element.succes));
      msg = ref.watch(authviewProvider.select((element) => element.message));
    }

    if (!loading) {
      _controller.forward();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: loading
                  ? Container(
                alignment: Alignment.center,
                height: 45,
                width: 45,
                child: const CircularProgressIndicator(
                  color: ColorName.bleu,
                  backgroundColor: ColorName.webwhite,
                ),
              )
                  : succes
                  ? ScaleTransition(
                scale: _iconScale,
                child: const Icon(
                  Icons.check,
                  color: const Color(0xFF2196F3),
                  size: 100,
                ),
              )
                  : ScaleTransition(
                scale: _iconScale,
                child: const Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 100,
                ),
              ),
            ),
            Space.verticale(heigth: 10),
            Text(msg,
                textAlign: TextAlign.center,
                style: context.textStyle(
                    fontWeight: FontWeight.w800, fontSize: 15))
          ],
        ),
      ),


    );
  }
}

class CustomAlertDialogWallet extends ConsumerStatefulWidget {
  final bool with_cancel;
  const CustomAlertDialogWallet (
      {super.key,
        this.with_cancel = false});

  @override
  ConsumerState<CustomAlertDialogWallet> createState() => _CustomAlertDialogWalletState();
}

class _CustomAlertDialogWalletState extends ConsumerState<CustomAlertDialogWallet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;

  bool loading = false, succes = false;
  String msg = "";
  String account = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!loading) {
      _controller.forward();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        //height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: loading
                  ? Container(
                alignment: Alignment.center,
                height: 45,
                width: 45,
                child: const CircularProgressIndicator(
                  color: ColorName.bleu,
                  backgroundColor: ColorName.webwhite,
                ),
              )
                  : succes
                  ? ScaleTransition(
                scale: _iconScale,
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF2196F3),
                  size: 100,
                ),
              )
                  : ScaleTransition(
                scale: _iconScale,
                child: const Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 100,
                ),
              ),
            ),
            Space.verticale(heigth: 10),
            //Text("Connexion en cours ....")
            Text(msg,
                textAlign: TextAlign.center,
                style: context.textStyle(
                    fontWeight: FontWeight.w800, fontSize: 15))
          ],
        ),
      ),
      actions: [
        if (!loading &&
            succes &&
            widget.with_cancel)
          TextButton(
            onPressed: () {},

                //context.pushNamed(RoutesNames.Code,extra: account),
            child: const Text('OK'),
          ),
        if (!loading &&
            succes  &&
            widget.with_cancel)
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Annuler'),
          ),
        if (!loading &&
            !succes)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
      ],

    );
  }
}

class CustomSuccesDialog extends ConsumerStatefulWidget {
  final String message;
  final bool succes;
  const CustomSuccesDialog(
      {super.key, required this.message, required this.succes});

  @override
  ConsumerState<CustomSuccesDialog> createState() => _CustomSuccesDialogState();
}

class _CustomSuccesDialogState extends ConsumerState<CustomSuccesDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    // Simulate a network request
    //Future.delayed(const Duration(seconds: 2), () {
    //setState(() {
    //    _isSuccess = true;
    //});
    _controller.forward();
    //});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: widget.succes
                  ? ScaleTransition(
                      scale: _iconScale,
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF2196F3),
                        size: 100,
                      ),
                    )
                  : ScaleTransition(
                      scale: _iconScale,
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 100,
                      ),
                    ),
            ),
            Space.verticale(heigth: 10),
            //Text("Connexion en cours ....")
            Text(widget.message,
                textAlign: TextAlign.center,
                style: context.textStyle(
                    fontWeight: FontWeight.w800, fontSize: 15))
          ],
        ),
      ),

      /*
      actions: [

          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),

      ],

       */
    );
  }
}
