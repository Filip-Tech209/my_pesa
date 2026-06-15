import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_pesa/theme.dart';
import '../models/transaction_model.dart';

class HistoryPage extends StatelessWidget {
  final List<Transaction> transactions;

  const HistoryPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 1. Filter and Sort Transactions
    final sortedTransactions = transactions.where((t) {
      return t.date.isNotEmpty && t.date != "N/A";
    }).toList()
      ..sort((a, b) {
        DateTime dateA = DateTime.tryParse(a.date) ?? DateTime(1970);
        DateTime dateB = DateTime.tryParse(b.date) ?? DateTime(1970);
        return dateB.compareTo(dateA); // Newest first
      });

    // 2. Group by "Year - Month"
    Map<String, List<Transaction>> grouped = {};
    for (var tx in sortedTransactions) {
      DateTime date = DateTime.tryParse(tx.date) ?? DateTime(1970);
      String key = DateFormat('MMMM yyyy').format(date); // e.g., "October 2024"
      if (!grouped.containsKey(key)) grouped[key] = [];
      grouped[key]!.add(tx);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: grouped.isEmpty
          ? const Center(child: Text("No transactions found"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: grouped.length,
              itemBuilder: (context, groupIndex) {
                String monthKey = grouped.keys.elementAt(groupIndex);
                List<Transaction> monthTransactions = grouped[monthKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Text(monthKey, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryBlue)),
                    ),
                    
                    // Transaction Cards
                    ...monthTransactions.map((item) => Container(
                      margin: const EdgeInsets.only(bottom: 12), // Spacing between cards
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                          child: const Icon(Icons.receipt_long, color: AppColors.primaryBlue),
                        ),
                        title: Text(item.description, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item.formattedDate, style: TextStyle(color: Colors.grey[600])),
                        trailing: Text(
                          "KES ${item.amount.toStringAsFixed(2)}",
                          style: const TextStyle(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                );
              },
            ),
    );
  }
}