import 'dart:async';
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
// import 'package:my_pesa/apis/api_services.dart';
import 'package:my_pesa/models/data_model.dart';


class HomeController extends GetxController {
  // final ApiService _apiService = ApiService();
  var accountData = Rxn<UserAccount>();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    loadData();
    // Refresh data every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      loadData();
    });
  }

  // void loadData() async {
  //   try {
  //     final data = await _apiService.fetchAccountData();
  //     accountData.value = data;
  //   } catch (e) {
  //     print("Error fetching from Sheets: $e");
  //   }
  // }
  void loadData() async {
  try {
    final response = await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbz4qO4YPxE50ndFGo2dtbEUvU_1gc2VycPEqMIIAHju_KFyABjbHctDSDojHnd2Fh2K/exec"));
    print("RAW JSON RESPONSE: ${response.body}"); // ADD THIS LINE!
    
    final data = UserAccount.fromJson(json.decode(response.body));
    accountData.value = data;
  } catch (e) {
    print("PARSING ERROR: $e"); // This will show you which field is failing
  }
}

  @override
  void onClose() {
    _timer?.cancel(); // Important to stop the timer when page closes
    super.onClose();
  }
}

