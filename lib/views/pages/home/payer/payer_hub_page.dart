import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayerHubPage extends ConsumerStatefulWidget {
  const PayerHubPage({super.key});

  @override
  ConsumerState<PayerHubPage> createState() => _PayerHubPageState();
}

class _PayerHubPageState extends ConsumerState<PayerHubPage> {
  int _currentIndex = 1; // "Transactions" (Payer)
  String _selectedMethod = 'QR';
  String _selectedNetwork = 'MTN';
  final _amountController = TextEditingController(text: '5000');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      l10n.payer_title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Envoyez un paiement vers un numéro, QR,\nlien ou marchand.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Montant Input / Display
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Montant',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                              suffixText: 'FCFA',
                              suffixStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Méthode
                    const Text(
                      "Méthode",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Methods Grid
                    Row(
                      children: [
                        Expanded(child: _buildMethodCard('QR')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMethodCard('Numéro')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildMethodCard('Lien')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMethodCard('Marchand')),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Réseau PSP
                    const Text(
                      "Réseau PSP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Networks Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildNetworkCard(
                            'MTN',
                            const Color(0xFFFFCC00),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildNetworkCard(
                            'Moov',
                            const Color(0xFF005C9A),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildNetworkCard(
                            'Carte',
                            const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Action Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedMethod == 'QR') {
                      context.pushNamed(RoutesNames.PayerQR);
                    } else if (_selectedMethod == 'Numéro') {
                      context.pushNamed(RoutesNames.PayerForm);
                    } else if (_selectedMethod == 'Lien') {
                      context.pushNamed(RoutesNames.PayerLink);
                    } else if (_selectedMethod == 'Marchand') {
                      context.pushNamed(RoutesNames.PayerMerchant);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continuer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1.0),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              if (index == 0) context.pushNamed(RoutesNames.Home);
              if (index == 1) context.pushNamed(RoutesNames.Payer);
              if (index == 2) context.pushNamed(RoutesNames.AddCarte);
              if (index == 3) context.pushNamed(RoutesNames.Profil);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.home_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.home),
                ),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.swap_horiz),
                ),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.credit_card_outlined),
                ),
                label: 'Cartes',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.sentiment_satisfied_alt),
                ),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard(String title) {
    final isSelected = _selectedMethod == title;

    Widget iconWidget;
    if (title == 'Marchand') {
      iconWidget = Text(
        'M',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xFF111827),
        ),
      );
    } else if (title == 'Numéro') {
      iconWidget = Text(
        '#',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xFF111827),
        ),
      );
    } else if (title == 'QR') {
      iconWidget = Icon(
        Icons.grid_on_rounded,
        color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xFF111827),
        size: 20,
      );
    } else {
      // Lien
      iconWidget = Icon(
        Icons.bolt_rounded,
        color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xFF111827),
        size: 22,
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkCard(String title, Color brandColor) {
    final isSelected = _selectedNetwork == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNetwork = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? brandColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? brandColor : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: brandColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black87 : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

