import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/globalwidget/buttons/bigbutton.dart';

/// Type de carte renvoyé par l’API (montant / libellé).
class CardTypeOption {
  const CardTypeOption({
    required this.id,
    required this.label,
    required this.amountLabel,
  });

  final String id;
  final String label;
  final String amountLabel;
}

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? securityCode;
  bool saveForFuture = true;

  /// Simulation GET types de cartes — remplacer par appel API.
  static const List<CardTypeOption> _mockTypesFromApi = [
    CardTypeOption(id: 'std', label: 'Carte standard', amountLabel: '2 500 FCFA'),
    CardTypeOption(id: 'pro', label: 'Carte pro', amountLabel: '10 000 FCFA'),
    CardTypeOption(id: 'biz', label: 'Carte business', amountLabel: '25 000 FCFA'),
  ];

  CardTypeOption? _selectedType = _mockTypesFromApi.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une carte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nouvelle carte',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez le type (prix affiché selon l’API), puis complétez les informations.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<CardTypeOption>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type de carte',
                  border: OutlineInputBorder(),
                ),
                items: _mockTypesFromApi
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: Text('${t.label} — ${t.amountLabel}'),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedType = v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Numéro de carte',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => cardNumber = value.replaceAll(RegExp(r'\s+'), ''),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expiration (MM/AA)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => expiryMonth = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      onChanged: (value) => securityCode = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Text('Enregistrer pour plus tard')),
                  Switch(
                    value: saveForFuture,
                    onChanged: (value) => setState(() => saveForFuture = value),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: BigButton(
                    labelText: 'Ajouter la carte',
                    backgroundClr: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fixedSized: const Size(350, 48),
                    size: 17,
                    circle: 4,
                    buttonSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('À brancher sur l’API d’ajout de carte.')),
                      );
                      context.pop();
                    },
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
