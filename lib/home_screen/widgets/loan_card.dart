import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_pesa/models/data_model.dart';
import 'package:my_pesa/theme.dart';

class LoanCard extends StatefulWidget {
  final UserAccount account;
  final String currencySymbol;

  const LoanCard({super.key, required this.account, required this.currencySymbol});

  @override
  State<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends State<LoanCard> {
  bool _obscureBalance = true;
  final formatter = NumberFormat("#,###");

  // Logic for progress bar color
  Color _getProgressColor(double progress) {
    if (progress <= 0.3) return Colors.red;
    if (progress <= 0.5) return Colors.orange;
    if (progress <= 0.7) return Colors.lightBlue;
    return Colors.green;
  }

  // Logic for due date
  String _getDaysRemaining() {
    DateTime appliedDate = DateTime(2025, 3, 11);
    DateTime dueDate = appliedDate.add(const Duration(days: 365));
    int daysRemaining = dueDate.difference(DateTime.now()).inDays;
    return daysRemaining > 0 ? "$daysRemaining days remaining" : "Overdue";
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.account.totalLoan > 0 
        ? (widget.account.paidLoan / widget.account.totalLoan).clamp(0.0, 1.0) 
        : 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LOAN BALANCE', style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => setState(() => _obscureBalance = !_obscureBalance),
                child: Icon(_obscureBalance ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryBlue, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _obscureBalance ? "KES ******" : "${widget.currencySymbol} ${formatter.format(widget.account.balanceLoan)}",
            style: const TextStyle(color: AppColors.primaryBlue, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              color: _getProgressColor(progress), // Dynamic color
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 10),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Paid: ${widget.currencySymbol} ${formatter.format(widget.account.paidLoan)}", 
                  style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.8), fontSize: 12)),
              Text("{(progress * 100).toInt()}% Paid", 
                  style: TextStyle(color: _getProgressColor(progress), fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(_getDaysRemaining(), style: TextStyle(color: Colors.grey[600], fontSize: 11, fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}