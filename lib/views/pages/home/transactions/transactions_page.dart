import 'package:flutter/material.dart';
import 'package:fripay/views/utils/globalwidget/app_bottom_nav_bar.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final int _currentIndex = 1; // "Transactions" tab

  final List<Map<String, dynamic>> _mockTransactions = [
    {
      'title': 'Carte virtuelle',
      'subtitle': 'Recharge carte',
      'amount': '25 000 FCFA',
      'type': 'in', // in, out, pending
    },
    {
      'title': 'Frais service',
      'subtitle': 'FrikPay',
      'amount': '-250 FCFA',
      'type': 'out',
    },
    {
      'title': 'Lien paiement',
      'subtitle': 'Marchand',
      'amount': '2 500 FCFA',
      'type': 'pending',
    },
    {
      'title': 'Retrait',
      'subtitle': 'Mobile Money',
      'amount': '-15 000 FCFA',
      'type': 'out',
    },
    {
      'title': 'Paiement marchand',
      'subtitle': 'Boutique',
      'amount': '-5 000 FCFA',
      'type': 'out',
    },
    {
      'title': 'Encaissement QR',
      'subtitle': 'Client',
      'amount': '12 500 FCFA',
      'type': 'in',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ),
            
            // List of transactions
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                itemCount: _mockTransactions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final transaction = _mockTransactions[index];
                  return _buildTransactionItem(
                    title: transaction['title'] as String,
                    subtitle: transaction['subtitle'] as String,
                    amount: transaction['amount'] as String,
                    type: transaction['type'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String subtitle,
    required String amount,
    required String type,
  }) {
    // Determine colors and icons based on type
    Color iconColor;
    Color bgColor;
    Color amountColor;
    IconData iconData;

    switch (type) {
      case 'in':
        iconColor = const Color(0xFF2196F3);
        bgColor = const Color(0xFFE3F2FD);
        amountColor = const Color(0xFF2196F3);
        iconData = Icons.arrow_downward_rounded;
        break;
      case 'out':
        iconColor = Colors.red.shade600;
        bgColor = Colors.red.shade50;
        amountColor = Colors.red.shade600;
        iconData = Icons.arrow_upward_rounded;
        break;
      case 'pending':
      default:
        iconColor = Colors.orange.shade600;
        bgColor = Colors.orange.shade50;
        amountColor = Colors.orange.shade600;
        iconData = Icons.arrow_downward_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Amount
          const SizedBox(width: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
