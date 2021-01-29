import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var rateMessage = [];
  CoinData coinData = CoinData();

  Future getCoinData(String currency) async {
    List<dynamic> coinDataList = List();

    for (String cryptoCurrency in cryptoList) {
      var data = await coinData.getCoinData(
          cryptoCurrency: cryptoCurrency, currency: currency);
      coinDataList.add(data);
    }

    return coinDataList;
  }

  @override
  void initState() {
    super.initState();
    for (String cryptoCurrency in cryptoList) {
      rateMessage.add("1 $cryptoCurrency : ? $selectedCurrency");
    }
    updateUI(getCoinData(selectedCurrency));
  }

  void updateUI(Future<dynamic> coinDataFuture) async {
    final List<dynamic> coinData = await coinDataFuture;

    setState(() {
      for (int i = 0; i < coinData.length; i++) {
        if (coinData[i] == null) {
          rateMessage[i] = "Unable to get Coin Data";
        } else {
          rateMessage[i] =
              "1 ${cryptoList[i]} = ${coinData[i]['rate'].toStringAsFixed(0)} $selectedCurrency";
        }
      }
    });
  }

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        selectedCurrency = value;
        updateUI(getCoinData(selectedCurrency));
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        updateUI(getCoinData(selectedCurrency));
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < cryptoList.length; i++)
                  CryptoCard(message: rateMessage[i]),
              ]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String message;

  CryptoCard({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
