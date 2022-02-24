import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/currenciesJson.dart';
import 'package:pro_it/services/currencyApi.dart';
import 'package:pro_it/utilities/utls.dart';

class CurrencyController extends GetxController {
  var from = "USD".obs;
  var to = "USD".obs;

  var currSymbol = "\$".obs;

  var rate = 1.0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void changeCurrency(String val) async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Utils.showSnackBar("Check Your Internet Connection!", "Try again later");
    } else {
      rate.value = await CurrencyApi.getRate(from.value, val);
      if (rate.value == 0.0) {
        rate.value = 1.0;
        Utils.showSnackBar("Error!", "Something went wrong. Try again later.");
        update();
      } else {
        to.value = val;
        currSymbol.value =
            CurrenciesJson.currencies['${to.value}']!['currencySymbol']!;
        update();
      }
    }
  }
}
