import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/foundation.dart';

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
  'ZAR',
  'CLP',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseURL = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  Future<dynamic> getCoinData(
      {@required String cryptoCurrency, @required String currency}) async {
    String url = "$baseURL$cryptoCurrency/$currency";

    NetworkHelper networkHelper = NetworkHelper(url);

    var coinData = await networkHelper.getData();
    return coinData;
  }
}
