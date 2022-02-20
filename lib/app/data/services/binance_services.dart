import 'dart:convert';

import 'package:bottrading/app/data/models/accountInformation.dart';
import 'package:http/http.dart' as http;

class BinanceServices {
  static var client = http.Client();
  static String urlBinance = "https://testnet.binance.vision";

  static Future<AccountInformation?> fetchAuthentication() async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json; charset=utf-8",
      "X-MBX-APIKEY":
          "2x3tr62pm9758LUpiC1JeSKH3Nowxb3ajeM8XbOwNXeBJC7IOkMgGOIa6VDfEUHb"
    };
    var body = jsonEncode({"timestamp": 100});
    var response = await client.post(
        Uri.parse('https://api.binance.com/api/v3/account'),
        body: body,
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return accountInformationFromJson(jsonString);
    } else {
      return null;
    }
  }
}
