import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

const coinapiURL = 'https://rest.coinapi.io/v1/exchangerate/';
const apikey = '33F87293-3ABD-4159-AD86-9C82AEAB62FC';

//BTC/USD?apikey=33F87293-3ABD-4159-AD86-9C82AEAB62FC
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcDisplay = '?';
  String ethDisplay = '?';
  String ltcDisplay = '?';

  @override
  void initState() {
    super.initState();
    updateAllPrices();
  }

  void updateAllPrices() async {
    await updatePrice('BTC', selectedCurrency);
    await updatePrice('ETH', selectedCurrency);
    await updatePrice('LTC', selectedCurrency);
  }

  void updatePrice(String crypto, String currency) async {
    http.Response response = await http.get(
        Uri.parse(coinapiURL + crypto + '/' + currency + '?apikey=' + apikey));

    if (response.statusCode == 200) {
      String data = response.body;

      setState(() {
        if (crypto == 'BTC') {
          double temprate = jsonDecode(data)['rate'];
          btcDisplay = temprate.toInt().toString();
        } else if (crypto == 'ETH') {
          double temprate = jsonDecode(data)['rate'];
          ethDisplay = temprate.toInt().toString();
        } else if (crypto == 'LTC') {
          double temprate = jsonDecode(data)['rate'];
          ltcDisplay = temprate.toInt().toString();
        }
      });
    } else {
      if (crypto == 'BTC') {
        btcDisplay = '?';
      } else if (crypto == 'ETH') {
        ethDisplay = '?';
      } else if (crypto == 'LTC') {
        ltcDisplay = '?';
      }
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          btcDisplay = '?';
          ethDisplay = '?';
          ltcDisplay = '?';
          updateAllPrices();
        });
      },
      children: pickerItems,
      scrollController: FixedExtentScrollController(initialItem: 19),
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
          CryptoCard(
            crypto: 'BTC',
            currency: selectedCurrency,
            rate: btcDisplay,
          ),
          CryptoCard(
            crypto: 'ETH',
            currency: selectedCurrency,
            rate: ethDisplay,
          ),
          CryptoCard(
            crypto: 'LTC',
            currency: selectedCurrency,
            rate: ltcDisplay,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  String crypto;
  String currency;
  String rate;

  CryptoCard({this.crypto, this.currency, this.rate});

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
            '1 $crypto = $rate $currency',
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
