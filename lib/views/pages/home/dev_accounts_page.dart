import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/controllers/dev_account_controller.dart';
import 'package:fripay/controllers/init.dart';
import 'package:fripay/models/dev_account/dev_account.dart';
import 'package:fripay/views/utils/constantes.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:fripay/widgets/app_page_header.dart';

class DevAccountsPage extends ConsumerStatefulWidget {
  const DevAccountsPage({super.key});

  @override
  ConsumerState<DevAccountsPage> createState() => _DevAccountsPageState();
}

class _DevAccountsPageState extends ConsumerState<DevAccountsPage> {
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    final raw = interne_storage.read(selectedDeveloperAccountKey);
    _selectedId = raw is String ? raw : null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devAccountControllerProvider.notifier).fetchAccounts();
    });
  }

  void _select(DevAccount a) {
    setState(() => _selectedId = a.id);
    interne_storage.write(selectedDeveloperAccountKey, a.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Compte développeur actif : ${a.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devState = ref.watch(devAccountControllerProvider);
    final accounts = devState.accounts;

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
            child: devState.loading
                ? const Center(child: CircularProgressIndicator())
                : accounts.isEmpty
                    ? const Center(child: Text('Aucun compte développeur trouvé.'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: accounts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, i) {
                          final a = accounts[i];
                          final sel = _selectedId == a.id;
                          return Card(
                            color: sel ? Colors.blue.shade50 : null,
                            child: RadioListTile<String>(
                              value: a.id,
                              groupValue: _selectedId,
                              onChanged: (_) => _select(a),
                              title: Text(a.name),
                              subtitle: Text(
                                  'Statut: ${a.status == "1" ? "Actif" : "Inactif"}'),
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
