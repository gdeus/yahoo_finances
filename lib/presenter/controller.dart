import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../datasource/data_source.dart';

class Controller extends GetxController {
  late RxList<Row> values = <Row>[].obs;
  late RxList<FlSpot> chartData = <FlSpot>[].obs;
  RxBool loading = false.obs;

  void getData() async {
    RxBool loading = true.obs;
    var data = await DataSource.fetchData();
    values.value = data.values ?? [];
    print(values.length);
    values.forEach((element) { 
      chartData.add(FlSpot(element.time.toDouble(), element.value.toDouble()));
    });
    loading = false.obs;
  }
}
