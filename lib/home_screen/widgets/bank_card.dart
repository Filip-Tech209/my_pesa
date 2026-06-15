  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_pesa/models/data_model.dart';
import 'package:my_pesa/text_styles.dart';
import 'package:my_pesa/theme.dart';

class BankCard extends StatefulWidget {
  final UserAccount account;
  final double displaySaving; 
  final String currencySymbol;
  const BankCard(BuildContext context, {super.key, required this.account, required this.currencySymbol, required this.displaySaving});

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  bool _obscureBalance = true;
 final formatter = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AVAILABLE SAVING', style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
              GestureDetector(
                onTap: () => setState(() => _obscureBalance = !_obscureBalance),
                child: Icon(
                  _obscureBalance ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Text.rich(
            TextSpan(
              text: widget.currencySymbol == 'KES' ? 'KES ' : widget.currencySymbol == 'USD' ? '\$ ' : '€ ',
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.white70,
                fontSize: 18, // Smaller font size for "KES"
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: _obscureBalance 
                      ? '******' 
                      : formatter.format(widget.displaySaving),
                  style: AppTextStyles.h1.copyWith(
                    color: Colors.white,
                    fontSize: 32, // Large font size for the value
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardDetailBlock('ACCOUNT NUMBER', '•••• •••• •••• 8842'),
              _buildCardDetailBlock('MEMBER NUMBER', widget.account.memberNo.toString(), isLarge: true),
            ],
          ),
          const SizedBox(height: 16),
          Text('MEMBER NAME', style: AppTextStyles.labelSmall.copyWith(color: Colors.white60, fontSize: 10)),
          Text(widget.account.memberName, style: AppTextStyles.labelMedium.copyWith(color: Colors.white, letterSpacing: 1)),
        ],
      ),
    );
  }
  Widget _buildCardDetailBlock(String title, String data, {bool isLarge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelSmall.copyWith(color: Colors.white60, fontSize: 10)),
        const SizedBox(height: 2),
        Text(
          data, 
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'Courier', 
            fontSize: isLarge ? 28 : 14, // Bigger font for Member No
            fontWeight: FontWeight.bold
          )
        ),
      ],
    );
  }
}