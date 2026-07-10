import 'package:flutter/material.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EncaissementListPage extends ConsumerStatefulWidget {
  const EncaissementListPage({super.key});

  @override
  ConsumerState<EncaissementListPage> createState() =>
      _EncaissementListPageState();
}

class _EncaissementListPageState extends ConsumerState<EncaissementListPage> {
  int _currentIndex = 0;
  String _selectedMode = 'QR Code';

  // For Demande form
  String _selectedNetwork = 'MTN';
  final _phoneController = TextEditingController();
  String? _phoneNumber;
  final String _initialCountry = 'BJ';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Title
                    const Text(
                      'Encaisser',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      'Créez une demande de paiement en\nquelques secondes.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Montant Input / Display
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
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
                          const SizedBox(height: 4),
                          const Text(
                            '15 000 FCFA',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mode d'encaissement
                    const Text(
                      "Mode d'encaissement",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Modes Row
                    Row(
                      children: [
                        Expanded(child: _buildModeChip('QR Code')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildModeChip('Lien')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildModeChip('Demande')),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Dynamic Content Area
                    _buildDynamicContent(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Action Button
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              color: const Color(0xFFF8F9FA),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final message = _selectedMode == 'QR Code'
                        ? 'QR Code partagé avec succès'
                        : _selectedMode == 'Lien'
                        ? 'Lien copié/partagé avec succès'
                        : 'Demande envoyée avec succès';

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _selectedMode == 'QR Code'
                        ? 'Partager le QR Code'
                        : _selectedMode == 'Lien'
                        ? 'Partager le lien'
                        : 'Envoyer la demande',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          selectedItemColor: Colors.blue.shade600,
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
    );
  }

  Widget _buildDynamicContent() {
    if (_selectedMode == 'QR Code') {
      return Center(
        child: Container(
          width: 180,
          height: 180,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const _MockQrCode(),
        ),
      );
    } else if (_selectedMode == 'Lien') {
      return Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.link_rounded, size: 40, color: Colors.blue.shade500),
              const SizedBox(height: 12),
              const Text(
                'Lien de paiement généré',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'https://frikpay.com/pay/req-12345',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.copy_rounded,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Demande form
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations du payeur',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 16),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                _phoneNumber = number.phoneNumber;
              },
              initialValue: PhoneNumber(isoCode: _initialCountry),
              selectorConfig: const SelectorConfig(
                selectorType:
                    PhoneInputSelectorType.BOTTOM_SHEET, // Modern bottom sheet
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 16,
                useBottomSheetSafeArea: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black87),
              textFieldController: _phoneController,
              formatInput: true,
              keyboardType: TextInputType.phone,
              inputDecoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Réseau Mobile Money',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildNetworkCard('MTN', const Color(0xFFFFCC00)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNetworkCard('Moov', const Color(0xFF005C9A)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNetworkCard('Celtiis', const Color(0xFFE50000)),
                ),
              ],
            ),
          ],
        ),
      );
    }
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

  Widget _buildModeChip(String title) {
    final isSelected = _selectedMode == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade500 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue.shade500 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

// A widget to draw the dummy QR code pattern matching the mockup
class _MockQrCode extends StatelessWidget {
  const _MockQrCode();

  @override
  Widget build(BuildContext context) {
    // 6x6 grid pattern from the mockup image (1 = solid, 0 = empty)
    final pattern = [
      0,
      1,
      1,
      0,
      1,
      1,
      1,
      0,
      1,
      1,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      0,
      1,
      1,
      0,
      1,
      1,
      1,
      0,
      1,
      1,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: 36,
      itemBuilder: (context, index) {
        if (pattern[index] == 1) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111827), // Dark navy
              borderRadius: BorderRadius.circular(3),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
