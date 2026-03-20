import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/views/routes.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.home1} Joel AYEKOWOUI !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.home2,
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  Clickable(
                    onClick: () {
                      context.pushNamed(RoutesNames.Profil);
                    },
                    child: Card(
                      color: Colors.green[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, color: Colors.green, size: 40),
                          SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.home, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Clickable(
                    onClick: () {
                      context.pushNamed(RoutesNames.Home2);
                     // context.pushNamed(RoutesNames.Applications);
                    },
                    child: Card(
                      color: Colors.blue[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_android, color: Colors.blue, size: 40),
                          SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.home3, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Clickable(
                    onClick: () {
                      context.pushNamed(RoutesNames.AddCarte);
                    },
                    child: Card(
                      color: Colors.yellow[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card, color: Colors.yellow[800], size: 40),
                          SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.home4, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Clickable(
                    onClick: () {
                      context.pushNamed(RoutesNames.Applications);
                    },
                    child: Card(
                      color: Colors.pink[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.transfer_within_a_station, color: Colors.red, size: 40),
                          SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.home5, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}




class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '9:41 AM', // Mock time
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Row(
              children: [
                Icon(Icons.wifi, size: 16, color: Colors.black87),
                SizedBox(width: 4),
                Icon(Icons.battery_full, size: 16, color: Colors.black87),
                Text('100%', style: TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.grey[200], // Mimics the light grey background
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue, Joel AYEKOWOU !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Bienvenue dans notre service qui vous fera faire des transactions en toute sécurité.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                Card(
                  color: Colors.green[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.green, size: 40),
                      SizedBox(height: 8),
                      Text('Profil', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Card(
                  color: Colors.blue[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_android, color: Colors.blue, size: 40),
                      SizedBox(height: 8),
                      Text('Transfert', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Card(
                  color: Colors.yellow[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card, color: Colors.yellow[800], size: 40),
                      SizedBox(height: 8),
                      Text('Change', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Card(
                  color: Colors.pink[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.transfer_within_a_station, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text('Transfert rapide', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
