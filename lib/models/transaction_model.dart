import 'package:intl/intl.dart'; // Add this to your pubspec.yaml

class Transaction {
  final String date;
  final String description;
  final double amount;

  Transaction({required this.date, required this.description, required this.amount});

  // Helper to format the date string nicely
  String get formattedDate {
    try {
      if (date == "N/A" || date.isEmpty) return "No Date";
      // Assuming your Google Sheet sends ISO 8601 strings
      DateTime dt = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(dt); // e.g., "12 Jun 2026"
    } catch (e) {
      return date; // Return raw string if parsing fails
    }
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date']?.toString() ?? "N/A",
      description: json['description']?.toString() ?? "Saving",
      amount: (json['amount'] is num) ? (json['amount'] as num).toDouble() : 0.0,
    );
  }
}