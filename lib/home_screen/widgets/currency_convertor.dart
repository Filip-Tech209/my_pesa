import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConverterDialog {
  // Define exchange rates (e.g., 1 USD = 130 KES)
  static const Map<String, double> rates = {
    'USD': 130.0,
    'GBP': 165.0,
    'EUR': 140.0,
  };

  static void show(BuildContext context, int amountInKes, String currency) {
    double rate = rates[currency] ?? 1.0;
    double converted = amountInKes / rate;
    
    // Formatter for currency
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: currency == 'USD' ? '\$ ' : (currency == 'GBP' ? '£ ' : '€ '),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$currency Conversion'),
        content: Text(
          'Total Saving: ${formatter.format(converted)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
        ],
      ),
    );
  }
}