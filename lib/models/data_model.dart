// Ensure you have this file

import 'package:my_pesa/models/transaction_model.dart';

class UserAccount {
  final int totalSaving;
  final int totalLoan;
  final int paidLoan;
  final int balanceLoan;
  final String currentTime;
  final String currentDate;
  final String username;
  final String memberNo;
  final String memberName;
  final int shareCapital;
  final int password;
  final List<Transaction> transactions; // Merged field

  UserAccount({
    required this.totalSaving, required this.totalLoan, required this.paidLoan,
    required this.balanceLoan, required this.currentTime, required this.currentDate,
    required this.username, required this.memberNo, required this.memberName,
    required this.shareCapital, required this.password,
    required this.transactions,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    // Helper to safely convert anything to an int
    int toIntSafe(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return UserAccount(
      totalSaving: toIntSafe(json['totalSaving']),
      totalLoan: toIntSafe(json['totalLoan']),
      paidLoan: toIntSafe(json['paidLoan']),
      balanceLoan: toIntSafe(json['balanceLoan']),
      shareCapital: toIntSafe(json['shareCapital']),
      password: toIntSafe(json['password'] ?? 54321),
      
      currentTime: json['currentTime']?.toString() ?? "",
      currentDate: json['currentDate']?.toString() ?? "",
      username: json['username']?.toString() ?? "Guest",
      memberNo: json['memberNo']?.toString() ?? "N/A",
      memberName: json['memberName']?.toString() ?? "Unknown",
      
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((t) => Transaction.fromJson(t))
              .toList() ?? [],
    );
  }
}