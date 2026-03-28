import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/controllers/authview/authview.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/views/routes.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String _displayName() {
    final u = ref.watch(authviewProvider).user;
    if (u == null) return 'Joel AYEKOWOUI';
    final n = '${u.firstname} ${u.lastname}'.trim();
    return n.isEmpty ? 'Joel AYEKOWOUI' : n;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final tiles = AppTheme.homeTiles(cs);
    return GeneralScaffold(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            Text(
              l10n.home1,
              style: tt.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${_displayName()} !',
              style: tt.headlineMedium?.copyWith(
                fontSize: 28,
                height: 1.15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.home2,
              style: tt.bodyMedium?.copyWith(
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.97,
                children: [
                  _HomeMenuTile(
                    cardColor: tiles[0].cardBg,
                    circleColor: tiles[0].iconBg,
                    icon: Icons.point_of_sale_rounded,
                    label: l10n.home3,
                    onTap: () => context.pushNamed(RoutesNames.Encaisser),
                  ),
                  _HomeMenuTile(
                    cardColor: tiles[1].cardBg,
                    circleColor: tiles[1].iconBg,
                    icon: Icons.account_balance_wallet_rounded,
                    label: l10n.home5,
                    onTap: () => context.pushNamed(RoutesNames.Payer),
                  ),
                  _HomeMenuTile(
                    cardColor: tiles[2].cardBg,
                    circleColor: tiles[2].iconBg,
                    icon: Icons.credit_card_rounded,
                    label: l10n.home4,
                    onTap: () => context.pushNamed(RoutesNames.AddCarte),
                  ),
                  _HomeMenuTile(
                    cardColor: tiles[3].cardBg,
                    circleColor: tiles[3].iconBg,
                    icon: Icons.person_rounded,
                    label: l10n.home,
                    onTap: () => context.pushNamed(RoutesNames.Profil),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeMenuTile extends StatelessWidget {
  const _HomeMenuTile({
    required this.cardColor,
    required this.circleColor,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color cardColor;
  final Color circleColor;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurf = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: Colors.transparent,
      child: Clickable(
        onClick: onTap,
        child: Card(
          elevation: 0,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                    boxShadow: [
                      BoxShadow(
                        color: circleColor.withValues(alpha: 0.28),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 14),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: onSurf,
                        letterSpacing: -0.15,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '9:41 AM',
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
        backgroundColor: Colors.grey[200],
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
