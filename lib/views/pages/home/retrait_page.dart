import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';



class RetraitPage extends StatefulWidget {
  @override
  _RetraitPageState createState() => _RetraitPageState();
}

class _RetraitPageState extends State<RetraitPage> {
  final _formKey = GlobalKey<FormState>();
  String? mtcn;
  String? nom;
  String? prenoms;
  String? paysResidence;
  String? phoneNumber;
  String? initialCountry = 'BJ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Retrait'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vos informations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'MTCN'),
                onChanged: (value) => mtcn = value,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Nom'),
                      onChanged: (value) => nom = value,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Prénoms'),
                      onChanged: (value) => prenoms = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pays de résidence'),
                onChanged: (value) => paysResidence = value,
              ),
              SizedBox(height: 16),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNumber = number.phoneNumber;
                },
                initialValue: PhoneNumber(isoCode: initialCountry),
                selectorConfig: SelectorConfig(selectorType: PhoneInputSelectorType.DROPDOWN),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                textFieldController: TextEditingController(),
                formatInput: true,
                keyboardType: TextInputType.phone,
                inputDecoration: InputDecoration(labelText: 'Numéro de Téléphone'),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Continuer'),
                  style: ElevatedButton.styleFrom(
                    /*
                      primary: Colors.blue,
                    onPrimary: Colors.white,
                    */
                    minimumSize: Size(200, 50),
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