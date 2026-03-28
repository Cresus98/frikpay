import 'package:flutter/material.dart';
import 'package:fripay/controllers/init.dart';
import 'package:fripay/views/utils/constantes.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:fripay/widgets/app_page_header.dart';

/// Compte développeur (données de démo — à brancher sur l’API).
class DeveloperAccount {
  const DeveloperAccount({
    required this.id,
    required this.label,
    required this.description,
  });

  final String id;
  final String label;
  final String description;
}

class DevAccountsPage extends StatefulWidget {
  const DevAccountsPage({super.key});

  @override
  State<DevAccountsPage> createState() => _DevAccountsPageState();
}

class _DevAccountsPageState extends State<DevAccountsPage> {
  static const List<DeveloperAccount> _demo = [
    DeveloperAccount(
      id: 'dev-001',
      label: 'Compte boutique A',
      description: 'Production — paiements marchands',
    ),
    DeveloperAccount(
      id: 'dev-002',
      label: 'Compte test intégration',
      description: 'Sandbox',
    ),
  ];

  String? _selectedId;

  @override
  void initState() {
    super.initState();
    final raw = interne_storage.read(selectedDeveloperAccountKey);
    _selectedId = raw is String ? raw : null;
  }

  void _select(DeveloperAccount a) {
    setState(() => _selectedId = a.id);
    interne_storage.write(selectedDeveloperAccountKey, a.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Compte développeur actif : ${a.label}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: AppHeaderBar(title: 'Comptes développeurs'),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sélectionnez un compte pour effectuer les actions qui en dépendent.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _demo.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final a = _demo[i];
                final sel = _selectedId == a.id;
                return Card(
                  color: sel ? Colors.blue.shade50 : null,
                  child: RadioListTile<String>(
                    value: a.id,
                    groupValue: _selectedId,
                    onChanged: (_) => _select(a),
                    title: Text(a.label),
                    subtitle: Text(a.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
