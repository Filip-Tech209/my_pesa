import 'package:flutter/material.dart';
import 'package:my_pesa/text_styles.dart';
import 'package:my_pesa/theme.dart';

class OptionTabs extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  
  const OptionTabs(BuildContext context, {Key? key, 
    required this.label, 
    required this.icon,
    this.onTap
  }) : super(key: key);

  @override
  State<OptionTabs> createState() => _OptionTabsState();
}

class _OptionTabsState extends State<OptionTabs> {
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
            color: isDark ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))
            ],
          ),
          child: Icon(
            widget.icon, 
            color: AppColors.primaryBlue, size: 28
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label, 
          style: AppTextStyles.labelMedium
        ),
      ],
      )
    );
  }
}


  


 