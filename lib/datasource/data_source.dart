import 'dart:convert';
import 'package:http/http.dart' as http;

class Row {
  final dynamic day;
  final dynamic time;
  final dynamic value;
  final dynamic percent;
  final dynamic percentd;

  Row(this.day, this.time, this.value, this.percent, this.percentd);
}

class Data {
  final List<Row>? values;

  const Data({required this.values});

  factory Data.fromJson(Map<String, dynamic> json) {
    var time = json['chart']['result'][0]['timestamp'];
    var values = json['chart']['result'][0]["indicators"]["quote"][0]["open"];

    List<Row> rows = [];

    for (int i = 0; i < time.length - 1; i++) {
      var percentual = ((values[i + 1] / values[i]) - 1) * 100;
      var row = Row(i, time[i], values[i], percentual, percentual);
      rows.add(row);
    }
    return Data(values: rows);
  }
}

class DataSource {
  static Future<Data> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA?symbol=PETR4.SA&period1=1669075200&period2=1671667200&useYfid=true&interval=1d&includePrePost=true&events=div%7Csplit%7Cearn&lang=en-US&region=US&crumb=xjqacEZLRQZ'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print(response.body);
      return Data.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Data');
    }
  }
}
