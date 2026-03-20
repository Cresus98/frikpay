import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/buttons/bigbutton.dart';
import 'package:fripay/views/utils/globalwidget/space.dart' show Space;
import 'package:go_router/go_router.dart';

import '../../../controllers/authview/authview.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../routes.dart';
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

class RequestButton extends StatelessWidget {
  Future<void> makeRequest(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitCircle(color: Colors.blue),
        );
      },
    );

    try {
      final response =
          await Dio().request('https://jsonplaceholder.typicode.com/posts/1');

      Navigator.of(context).pop(); // Close the loading dialog

      if (response.statusCode == 200) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog();
          },
        );
      } else {
        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog();
          },
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => makeRequest(context),
      child: Text('Make Request'),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 50),
          SizedBox(height: 10),
          Text('Success!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('The operation was completed successfully.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}

class ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text('Error!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Something went wrong. Please try again.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
//class MyAppTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Animated AlertDialog'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => showCustomDialog(context, true),
            child: Text('Show Success Dialog'),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAnimatedDialog(
          isSuccess: isSuccess,
          onConfirm: () {
            print("Yes tapped");
            Navigator.of(context).pop();
          },
          onCancel: () {
            print("No tapped");
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class CustomAnimatedDialog extends StatefulWidget {
  final bool isSuccess;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAnimatedDialog({
    Key? key,
    required this.isSuccess,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  _CustomAnimatedDialogState createState() => _CustomAnimatedDialogState();
}

class _CustomAnimatedDialogState extends State<CustomAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(widget.isSuccess ? 'Success' : 'Error'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.isSuccess ? Icons.check_circle : Icons.error,
              color: widget.isSuccess ? Colors.green : Colors.red,
              size: 60,
            ),
            SizedBox(height: 10),
            Text(widget.isSuccess
                ? 'The operation was successful!'
                : 'An error occurred.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: widget.onCancel,
            child: Text('No'),
          ),
          TextButton(
            onPressed: widget.onConfirm,
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

class MyAppTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Success Dialog'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => showAnimatedDialog(context),
            child: Text('Show Save Alert'),
          ),
        ),
      ),
    );
  }

  void showAnimatedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SaveAlertDialog(),
    );
  }
}

class SaveAlertDialog extends StatefulWidget {
  @override
  _SaveAlertDialogState createState() => _SaveAlertDialogState();
}

class _SaveAlertDialogState extends State<SaveAlertDialog>
    with SingleTickerProviderStateMixin {
  bool _isSuccess = false;
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
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSuccess = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        height: 150,
        child: Center(
          child: _isSuccess
              ? ScaleTransition(
                  scale: _iconScale,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
      actions: [
        if (_isSuccess)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
      ],
    );
  }
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
                    colour: succes?Colors.green:ColorName.red,
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
                  colour: succes?Colors.green:ColorName.red,
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
                  color: Colors.green,
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
                  color: Colors.green,
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
                        color: Colors.green,
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
