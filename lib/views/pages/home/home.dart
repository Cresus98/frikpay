import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/authview/authview.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart';
import '../../utils/globalwidget/app_bottom_nav_bar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authviewProvider);
    final user = authState.user;
    
    final fullName = (user?.firstname != null && user!.firstname.isNotEmpty) 
        ? "${user.firstname} ${user.lastname}".trim()
        : (authState.account.isNotEmpty ? authState.account : "Utilisateur");

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background matching mockup
      body: SafeArea(bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Bonjour $fullName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Compte personnel',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827), // Dark navy/black
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solde disponible',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '125 000 FCFA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Wallet FrikPay',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.arrow_downward_rounded,
                      label: l10n.encaisser,
                      iconColor: scheme.primary,
                      bgColor: scheme.primary.withOpacity(0.08),
                      onTap: () => context.pushNamed(RoutesNames.Encaisser),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.arrow_upward_rounded,
                      label: l10n.payer,
                      iconColor: scheme.primary,
                      bgColor: scheme.primary.withOpacity(0.08),
                      onTap: () => context.pushNamed(RoutesNames.Payer),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Recent Activity Title
              const Text(
                'Activité récente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 20),

              // Recent Activity List
              const _ActivityItem(
                title: 'Paiement reçu',
                subtitle: 'Réussi',
                amount: '+15 000 FCFA',
                isPositive: true,
                isPending: false,
                icon: Icons.add,
              ),
              const _ActivityItem(
                title: 'Paiement marchand',
                subtitle: 'Réussi',
                amount: '-5 000 FCFA',
                isPositive: false,
                isPending: false,
                icon: Icons.remove,
              ),
              const _ActivityItem(
                title: 'Lien de paiement',
                subtitle: 'En attente',
                amount: '+2 500 FCFA',
                isPositive: true,
                isPending: true,
                icon: Icons.add,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onClick: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isPositive,
    required this.isPending,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String amount;
  final bool isPositive;
  final bool isPending;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color amountColor;
    
    if (isPending) {
      iconColor = Colors.orange;
      amountColor = Colors.orange;
    } else if (isPositive) {
      iconColor = const Color(0xFF2196F3);
      amountColor = const Color(0xFF2196F3);
    } else {
      iconColor = Colors.red;
      amountColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6), // light grey
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
