import 'package:http/http.dart' as http;
import 'dart:convert';

const coinAPIKey = '9FCC30BF-E2FD-4432-83C6-23F7ECEA8349';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response =
        await http.get(url, headers: {'X-CoinAPI-Key': coinAPIKey});

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
