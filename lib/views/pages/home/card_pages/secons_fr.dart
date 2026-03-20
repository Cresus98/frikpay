import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../../../utils/globalwidget/buttons/bigbutton.dart';


class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? securityCode;
  bool saveForFuture = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new card',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'We recommend you to set card for further reference too you can use it anytime',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Card number',
                  prefixText: '竄ｦ ',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => cardNumber = value.replaceAll(RegExp(r'\s+'), '').replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Expiry Date'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => expiryMonth = value,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Security Code'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => securityCode = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Save this card for future reference'),
                  Spacer(),
                  Switch(
                    value: saveForFuture,
                    onChanged: (value) {
                      setState(() {
                        saveForFuture = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Spacer(),
              Center(
                child:      Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: BigButton(
                    labelText:  'Ajouter la Carte',
                    backgroundClr:  ColorName.bleu,
                    color:ColorName.webwhite,
                    fixedSized: Size(350, 48),
                    size: 17,
                    circle: 4,
                    buttonSide: const BorderSide(
                      color: ColorName.bleu,
                      width: 1,
                    ),
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                     // context.pushNamed(RoutesNames.Home1);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}