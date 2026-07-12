import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/globalwidget/app_bottom_nav_bar.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

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
  final _amountController = TextEditingController(text: '15000');
  String? _phoneNumber;
  final String _initialCountry = 'BJ';

  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        titleSpacing: 20,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Encaisser',
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            l10n.encaissement_montant,
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
                  onPressed: () async {
                    if (_selectedMode == 'Demande directe' || _selectedMode == 'Demande') {
                      context.pushNamed(RoutesNames.EncaissementForm);
                    } else if (_selectedMode == 'QR Code') {
                      final imageBytes = await _screenshotController.capture();
                      if (imageBytes != null) {
                        final directory = await getTemporaryDirectory();
                        final imagePath = await File('${directory.path}/qr_code.png').create();
                        await imagePath.writeAsBytes(imageBytes);
                        await Share.shareXFiles([XFile(imagePath.path)], text: 'Mon QR Code de paiement FrikPay');
                      }
                    } else if (_selectedMode == 'Lien') {
                      await Share.share('https://frikpay.com/pay/req-12345');
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
      );
  }

  Widget _buildDynamicContent() {
    if (_selectedMode == 'QR Code') {
      return Center(
        child: Screenshot(
          controller: _screenshotController,
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
              Icon(Icons.link_rounded, size: 40, color: Theme.of(context).colorScheme.primary),
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
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(const ClipboardData(text: 'https://frikpay.com/pay/req-12345'));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Lien copié avec succès.')),
                          );
                        }
                      },
                      child: Icon(
                        Icons.copy_rounded,
                        size: 18,
                        color: Colors.grey.shade500,
                      ),
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
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
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

