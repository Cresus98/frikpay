import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/globalwidget/app_bottom_nav_bar.dart';

class CardsHubPage extends ConsumerStatefulWidget {
  const CardsHubPage({super.key});

  @override
  ConsumerState<CardsHubPage> createState() => _CardsHubPageState();
}

class _CardsHubPageState extends ConsumerState<CardsHubPage> {
  int _currentIndex = 2; // "Cartes" active tab

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        titleSpacing: 24,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Cartes',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  
                  // Subtitle
                  Text(
                    'Créez et gérez vos cartes virtuelles\nsécurisées.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                    
                    // Main Card Display
                    _buildMainCard(),
                    
                    const SizedBox(height: 32),
                    
                    // Action Buttons Row
                    Row(
                      children: [
                        Expanded(child: _buildActionButton('Créer', Icons.add_card, () {
                          context.pushNamed(RoutesNames.AddCarteStepper);
                        })),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionButton('Afficher', Icons.visibility_outlined, () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Affichage des détails de la carte')));
                        })),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionButton('Bloquer', Icons.block_outlined, () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Carte bloquée avec succès')));
                        })),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionButton(l10n.cards_recharger, Icons.add, () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recharge de la carte')));
                        })),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Autres cartes section
                    const Text(
                      'Autres cartes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildOtherCardRow('Master USD', 'Actif'),
                    const SizedBox(height: 16),
                    _buildOtherCardRow('Visa EUR', 'Gelée'),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildMainCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Blue circle decoration clipping outside slightly
          Positioned(
            right: -20,
            top: 40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade500,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VISA USD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Text(
                  '****  ****  ****  1234',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'JOEL A.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '08/29',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent, // no background
            ),
            child: Icon(icon, color: Colors.blue.shade600, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildOtherCardRow(String title, String status) {
    // Generate the icon matching the mockup
    Widget customIcon = Center(
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade500, width: 2),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Container(
            width: 4,
            height: 4,
            color: Colors.blue.shade500,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sélection de la carte: $title')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: customIcon,
          ),
          const SizedBox(width: 16),
          Column(
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
                status,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
      ),
    );
  }
}

