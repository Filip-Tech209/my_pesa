// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_pesa/controllers/home_controller.dart';
import 'package:my_pesa/home_screen/widgets/bank_card.dart';
import 'package:my_pesa/home_screen/widgets/header_row.dart';
import 'package:my_pesa/home_screen/widgets/loan_card.dart';
import 'package:my_pesa/home_screen/widgets/option_tabs.dart';
import 'package:my_pesa/home_screen/history_page.dart';
import '../text_styles.dart';

/// Navigation wrapper handling state tracking routing across tabs
class MainLayoutWrapper extends StatefulWidget {
  const MainLayoutWrapper({Key? key}) : super(key: key);

  @override
  State<MainLayoutWrapper> createState() => _MainLayoutWrapperState();
}

  class _MainLayoutWrapperState extends State<MainLayoutWrapper> {
    int _currentIndex = 0;
    final HomeController controller = Get.put(HomeController());

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Obx(() {
          // Build pages dynamically based on available data
          return IndexedStack(
            index: _currentIndex,
            children: [
              const HomeScreenView(),
              HistoryPage(transactions: controller.accountData.value?.transactions ?? []),
              const BlankPlaceholderScreen(title: 'Account Details'),
            ],
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      );
    }
  }

/// Primary operational screen containing target balance configurations
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  String selectedCurrency = 'KES';
  
  // Conversion rates
  final Map<String, double> rates = {'KES': 1.0, 'USD': 130.0, 'GBP': 165.0, 'EUR': 140.0};

  double convert(int amount) => amount / (rates[selectedCurrency] ?? 1.0);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.accountData.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.accountData.value!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderRow(context, data),
                const SizedBox(height: 28),

                // Pass the converted values to your BankCard
                // Assuming BankCard accepts dynamic values or specific types
                BankCard(
                  context, 
                  account: data, 
                  currencySymbol: selectedCurrency == 'KES' ? 'KES' : selectedCurrency == 'USD' ? '\$' : '€',
                  displaySaving: convert(data.totalSaving),
                ),

                const SizedBox(height: 32),
                Text('Convert Currency', style: AppTextStyles.h3),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCurrencyButton('USD', Icons.attach_money),
                    _buildCurrencyButton('GBP', Icons.currency_pound),
                    _buildCurrencyButton('EUR', Icons.euro_outlined),
                    _buildCurrencyButton('KES', Icons.money),
                  ],
                ),

                const SizedBox(height: 32),
  
                LoanCard(
                  account: data,
                  currencySymbol: selectedCurrency == 'KES' ? 'KES' : selectedCurrency == 'USD' ? '\$' : '€',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrencyButton(String label, IconData icon) {
    return OptionTabs(
      context,
      icon: icon,
      onTap: () => setState(() => selectedCurrency = label),
      label: label,
    );
  }
}

/// Fallback component framework for empty target pages (Settings & Account)
class BlankPlaceholderScreen extends StatelessWidget {
  final String title;
  const BlankPlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 38, 38))),
        elevation: 0,
      ),
      body: const Center(
        child: Icon(Icons.hourglass_empty, size: 48, color: Colors.grey),
      ),
    );
  }
}