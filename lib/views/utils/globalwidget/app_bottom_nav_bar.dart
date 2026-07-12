import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes.dart';

/// Shared bottom navigation bar used across all main pages.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == currentIndex) return;
            switch (index) {
              case 0:
                context.goNamed(RoutesNames.Home); // root → clears stack
                break;
              case 1:
                context.pushNamed(RoutesNames.Transactions);
                break;
              case 2:
                context.pushNamed(RoutesNames.AddCarte);
                break;
              case 3:
                context.pushNamed(RoutesNames.Profil);
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey.shade500,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.home_outlined)),
              activeIcon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.home)),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.swap_horiz)),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.credit_card_outlined)),
              activeIcon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.credit_card)),
              label: 'Cartes',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.sentiment_satisfied_alt)),
              activeIcon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.sentiment_satisfied)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
