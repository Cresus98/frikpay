import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fripay/controllers/card_controller.dart';
import 'package:fripay/gen/colors.gen.dart';
import 'package:fripay/views/utils/globalwidget/dialogs.dart';

const double _radiusSm = 8.0;
const double _radiusMd = 12.0;

// ─── Types de pièce d'identité disponibles ──────────────────────────────────
const List<String> _typePieceOptions = [
  'Carte nationale d\'identité',
  'Passeport',
  'Permis de conduire',
  'Carte de séjour',
  'Carte d\'électeur',
];

// ─── Durée de validité de la carte en mois ──────────────────────────────────
const List<String> _dureeOptions = ['12', '24', '36'];

class AddCardStepperPage extends ConsumerStatefulWidget {
  const AddCardStepperPage({super.key});

  @override
  ConsumerState<AddCardStepperPage> createState() => _AddCardStepperPageState();
}

class _AddCardStepperPageState extends ConsumerState<AddCardStepperPage> {
  int _currentStep = 0;

  // ── Clés de validation ──
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  // ── Étape 1 : Informations personnelles ──
  final _civilityCtrl      = TextEditingController();
  final _lastnameCtrl      = TextEditingController();
  final _firstnameCtrl     = TextEditingController();
  final _emailCtrl         = TextEditingController();
  final _telephoneCtrl     = TextEditingController();
  final _nationalityCtrl   = TextEditingController();
  final _birthdayCtrl      = TextEditingController();
  final _birthplaceCtrl    = TextEditingController();
  final _addressCtrl       = TextEditingController();
  final _cityCtrl          = TextEditingController();
  final _countryCodeCtrl   = TextEditingController();
  final _professionCtrl    = TextEditingController();

  // ── Étape 2 : Pièce d'identité ──
  String _selectedTypePiece        = _typePieceOptions.first;
  final _identityNumberCtrl        = TextEditingController();
  final _dateDeliveryCtrl          = TextEditingController();
  final _dateExpiryCtrl            = TextEditingController();
  final _placeEstablishmentCtrl    = TextEditingController();
  String _selectedDuree            = _dureeOptions.first;
  final _senderCtrl                = TextEditingController();

  // ── Étape 3 : Documents ──
  File? _photoFile;
  File? _pieceFile;

  bool _isSubmitting = false;

  // ─── Helpers ────────────────────────────────────────────────────────────────

  Future<void> _pickDate(TextEditingController ctrl) async {
    final now    = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx).colorScheme,
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _pickImage({required bool isPhoto}) async {
    final picked = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galerie'),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Caméra'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
        ]),
      ),
    );
    if (picked == null) return;
    final img = await ImagePicker().pickImage(source: picked, imageQuality: 80);
    if (img != null) {
      setState(() {
        if (isPhoto) {
          _photoFile = File(img.path);
        } else {
          _pieceFile = File(img.path);
        }
      });
    }
  }

  Future<void> _submit() async {
    if (_photoFile == null || _pieceFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez ajouter votre photo et votre pièce d\'identité.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    openDialogBox(context, '', const CustomAlertDialog());

    final success = await ref.read(cardControllerProvider.notifier).createCard(
          civility:           _civilityCtrl.text.trim(),
          lastname:           _lastnameCtrl.text.trim(),
          firstname:          _firstnameCtrl.text.trim(),
          email:              _emailCtrl.text.trim(),
          telephone:          _telephoneCtrl.text.trim(),
          nationality:        _nationalityCtrl.text.trim(),
          birthday:           _birthdayCtrl.text.trim(),
          birthplace:         _birthplaceCtrl.text.trim(),
          address:            _addressCtrl.text.trim(),
          city:               _cityCtrl.text.trim(),
          countryCode:        _countryCodeCtrl.text.trim(),
          profession:         _professionCtrl.text.trim(),
          identityNumber:     _identityNumberCtrl.text.trim(),
          typePiece:          _selectedTypePiece,
          dateDelivery:       _dateDeliveryCtrl.text.trim(),
          dateExpiry:         _dateExpiryCtrl.text.trim(),
          placeEstablishment: _placeEstablishmentCtrl.text.trim(),
          dateExpirationInMonths: _selectedDuree,
          sender:             _senderCtrl.text.trim(),
          photo:              _photoFile,
          piece:              _pieceFile,
        );

    setState(() => _isSubmitting = false);
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop(); // Ferme le loading dialog

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carte créée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    } else {
      final msg = ref.read(cardControllerProvider).message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    for (final c in [
      _civilityCtrl, _lastnameCtrl, _firstnameCtrl, _emailCtrl,
      _telephoneCtrl, _nationalityCtrl, _birthdayCtrl, _birthplaceCtrl,
      _addressCtrl, _cityCtrl, _countryCodeCtrl, _professionCtrl,
      _identityNumberCtrl, _dateDeliveryCtrl, _dateExpiryCtrl,
      _placeEstablishmentCtrl, _senderCtrl,
    ]) c.dispose();
    super.dispose();
  }

  // ─── UI ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: scheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Demande de carte',
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: scheme.copyWith(secondary: scheme.primary),
        ),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (step) {
            // Autoriser à revenir en arrière librement
            if (step < _currentStep) setState(() => _currentStep = step);
          },
          controlsBuilder: (context, details) => _buildControls(details),
          steps: [
            _buildStep1(),
            _buildStep2(),
            _buildStep3(),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(ControlsDetails details) {
    final scheme = Theme.of(context).colorScheme;
    final isLast = _currentStep == 2;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                foregroundColor: scheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_radiusSm),
                ),
              ),
              onPressed: _isSubmitting
                  ? null
                  : () {
                      if (isLast) {
                        _submit();
                      } else {
                        _goNext();
                      }
                    },
              child: Text(
                isLast ? 'Créer ma carte' : 'Suivant',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
          if (_currentStep > 0) ...[
            const SizedBox(width: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_radiusSm),
                ),
              ),
              onPressed: () => setState(() => _currentStep--),
              child: const Text('Retour'),
            ),
          ],
        ],
      ),
    );
  }

  void _goNext() {
    if (_currentStep == 0 && !(_step1Key.currentState?.validate() ?? false)) {
      return;
    }
    if (_currentStep == 1 && !(_step2Key.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _currentStep++);
  }

  // ─── Step 1 : Infos Personnelles ────────────────────────────────────────────

  Step _buildStep1() {
    final scheme = Theme.of(context).colorScheme;
    return Step(
      title: const Text('Informations personnelles',
          style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: const Text('Identité et coordonnées'),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      content: Form(
        key: _step1Key,
        child: Column(
          children: [
            _field('Civilité (Mr, Mme...)', _civilityCtrl, required: true, hint: 'Mr'),
            _field('Nom', _lastnameCtrl, required: true),
            _field('Prénom', _firstnameCtrl, required: true),
            _field('Email', _emailCtrl, required: true, type: TextInputType.emailAddress),
            _field('Téléphone', _telephoneCtrl, required: true, type: TextInputType.phone),
            _field('Nationalité', _nationalityCtrl, required: true, hint: 'ex: Béninoise'),
            _datePicker('Date de naissance', _birthdayCtrl, required: true),
            _field('Lieu de naissance', _birthplaceCtrl, required: true),
            _field('Adresse', _addressCtrl, required: true),
            _field('Ville', _cityCtrl, required: true),
            _field('Code pays', _countryCodeCtrl, required: true, hint: 'ex: BJ'),
            _field('Profession', _professionCtrl, required: true),
          ],
        ),
      ),
    );
  }

  // ─── Step 2 : Pièce d'identité ──────────────────────────────────────────────

  Step _buildStep2() {
    return Step(
      title: const Text('Pièce d\'identité',
          style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: const Text('Détails du document officiel'),
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      content: Form(
        key: _step2Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdownField(
              label: 'Type de pièce',
              value: _selectedTypePiece,
              items: _typePieceOptions,
              onChanged: (v) => setState(() => _selectedTypePiece = v!),
            ),
            _field('Numéro de la pièce', _identityNumberCtrl, required: true),
            _datePicker('Date de délivrance', _dateDeliveryCtrl, required: true),
            _datePicker('Date d\'expiration de la pièce', _dateExpiryCtrl, required: true),
            _field('Lieu d\'établissement', _placeEstablishmentCtrl, required: true),
            _dropdownField(
              label: 'Validité de la carte (mois)',
              value: _selectedDuree,
              items: _dureeOptions,
              onChanged: (v) => setState(() => _selectedDuree = v!),
            ),
            _field('Expéditeur (sender)', _senderCtrl, hint: 'optionnel'),
          ],
        ),
      ),
    );
  }

  // ─── Step 3 : Documents photo ───────────────────────────────────────────────

  Step _buildStep3() {
    return Step(
      title: const Text('Documents photo',
          style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: const Text('Selfie et pièce d\'identité'),
      isActive: _currentStep >= 2,
      state: StepState.indexed,
      content: Column(
        children: [
          _photoUploadCard(
            label: 'Votre selfie (photo)',
            icon: Icons.camera_alt_rounded,
            file: _photoFile,
            onTap: () => _pickImage(isPhoto: true),
          ),
          const SizedBox(height: 16),
          _photoUploadCard(
            label: 'Votre pièce d\'identité (recto)',
            icon: Icons.badge_rounded,
            file: _pieceFile,
            onTap: () => _pickImage(isPhoto: false),
          ),
          const SizedBox(height: 8),
          Text(
            'Les photos doivent être nettes, lisibles et non rognées.',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Widgets réutilisables ───────────────────────────────────────────────────

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool required = false,
    String? hint,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(_radiusSm)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null
            : null,
      ),
    );
  }

  Widget _datePicker(String label, TextEditingController ctrl, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        readOnly: true,
        onTap: () => _pickDate(ctrl),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'AAAA-MM-JJ',
          suffixIcon: const Icon(Icons.calendar_today_rounded),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(_radiusSm)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null
            : null,
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(_radiusSm)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _photoUploadCard({
    required String label,
    required IconData icon,
    required File? file,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: file != null ? 180 : 120,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(_radiusMd),
          border: Border.all(
            color: file != null ? scheme.primary : scheme.outlineVariant,
            width: file != null ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: file != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(file, fit: BoxFit.cover),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, color: scheme.onPrimary, size: 16),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 38, color: scheme.primary.withOpacity(0.6)),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style: TextStyle(
                      color: scheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Appuyer pour sélectionner',
                    style: TextStyle(
                      color: scheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
