
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../../../routes.dart';
import '../../../utils/globalwidget/buttons/bigbutton.dart';



class MyCardsPage extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My cards',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'All your cards will appear here, if you wish to add more you tap "add button" below',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/1200px-Visa_Inc._logo.svg.png',
                          height: 40,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '**** **** **** 4242',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'EXPIRY DATE 06/23',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'SUJAT SAYYED',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      'CARD HOLDER',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
              child:

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: BigButton(
                  labelText:  '+ Add Card',
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
                    context.pushNamed(RoutesNames.Home1);
                  },
                ),
              ),


            ),
            SizedBox(height: 16),
        /*
        Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  /*
                    primary: Colors.black,
                  onPrimary: Colors.white,
                  */
                  minimumSize: Size(200, 50),
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}