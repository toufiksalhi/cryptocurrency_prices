import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey='E7417E78-7554-4037-9349-B15F890A9AB5';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String? selectedCurrency;
  CoinData(this.selectedCurrency);
  Map<String, String> cryptoPrices = {};
  Future getCoinData() async {
    for (String coin in cryptoList) {
      final String url =
          'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        cryptoPrices[coin] = data['rate'].toStringAsFixed(0);
      } else {
        throw 'ERROR ON COIN_DATA';
      }
    }
    return cryptoPrices;
  }
}
