import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yahoo_variance_finance_app/models/data.dart';

class DataTransform {
  final List<DataModel>? values;

  const DataTransform({required this.values});

  factory DataTransform.fromJson(Map<String, dynamic> json) {
    var time = json['chart']['result'][0]['timestamp'];
    var values = json['chart']['result'][0]["indicators"]["quote"][0]["open"];

    List<DataModel> rows = [];

    var d1 = values[0];

    for (int i = 0; i < time.length - 1; i++) {
      var percent = ((values[i + 1] / values[i]) - 1) * 100;
      var percentd1 = ((values[i + 1] / d1) - 1) * 100;
      var row = DataModel(i, time[i].toDouble(), values[i], percent, percentd1);
      rows.add(row);
    }
    return DataTransform(values: rows);
  }
}

class DataSource {
  static Future<DataTransform> fetchData(String company) async {
    final response = await http.get(Uri.parse(
        'https://query2.finance.yahoo.com/v8/finance/chart/$company?period1=1669075200&period2=1671667200&useYfid=true&interval=1d&includePrePost=true&events=div%7Csplit%7Cearn&lang=en-US&region=US&crumb=xjqacEZLRQZ'));

    if (response.statusCode == 200) {
      return DataTransform.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
