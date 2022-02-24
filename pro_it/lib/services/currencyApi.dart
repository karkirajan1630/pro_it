import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pro_it/config/key.dart';

//USD to NPR rate
// https://free.currconv.com/api/v7/convert?q=USD_NPR&compact=ultra&apiKey=55c080e021c4256453aa

class CurrencyApi {
  static Uri currencyUrl = Uri.https(
      "free.currconv.com", "/api/v7/currencies", {"apiKey": "$CURRENCYAPIKEY"});

  // Unused
  // static Future<List<String>> getCurrencies() async {
  //   try {
  //     http.Response res = await http.get(currencyUrl);
  //     if (res.statusCode == 200) {
  //       var body = jsonDecode(res.body);
  //       var list = body["results"];
  //       print(list['ALL']['currencySymbol']);
  //       List<String> currencies = (list.keys).toList();
  //       return currencies;
  //     } else {
  //       throw Exception("Failed to connect to API");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return ["USD"];
  //   }
  // }

  static Future<double> getRate(String from, String to) async {
    try{
      final Uri rateUrl = Uri.https(
      "free.currconv.com",
      "/api/v7/convert",
      {
        "apiKey": "$CURRENCYAPIKEY",
        "q": "${from}_$to",
        "compact": "ultra"
      },
    );
    http.Response res = await http.get(rateUrl);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      return body["${from}_$to"];
    }else{
      throw Exception("Failed to connect to API");
    }
    }catch(e){
      print(e.toString());
      return 0.0;
    }
  }
}
