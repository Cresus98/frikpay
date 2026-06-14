import 'package:flutter/material.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:fripay/widgets/app_page_header.dart';

/// Liste des opérations (aperçu — à alimenter par API).
class OperationsListPage extends StatelessWidget {
  const OperationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      12,
      (i) => _OpItem(
        title: 'Opération #${1000 + i}',
        subtitle: i.isEven ? 'Encaissement' : 'Paiement',
        amount: '${(i + 1) * 500} FCFA',
        date: DateTime.now().subtract(Duration(hours: i)),
      ),
    );

    return GeneralScaffold(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: AppHeaderBar(title: 'Liste des opérations'),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, i) {
                final o = items[i];
                return Card(
                  child: ListTile(
                    title: Text(o.title),
                    subtitle: Text(
                      '${o.subtitle} · ${o.date.day}/${o.date.month} ${o.date.hour}h',
                    ),
                    trailing: Text(
                      o.amount,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
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

class _OpItem {
  _OpItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });

  final String title;
  final String subtitle;
  final String amount;
  final DateTime date;
}
