import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/models/data.dart';
import 'package:yahoo_variance_finance_app/models/item_dropdown.dart';

import '../datasource/data_source.dart';

class MainController extends GetxController {
  late RxList<DataModel> values = <DataModel>[].obs;
  late RxList<FlSpot> chartData = <FlSpot>[].obs;
  List<ItemDropdown> itemsDropdown = [
    ItemDropdown('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEtINZv4pizOQGuqMipQ-N9fLxGQO7rU0mwUuqDQ37yQ&s', 'Nubank', 'NU'),
    ItemDropdown('https://seeklogo.com/images/P/Petrobras-logo-03DABEE0AC-seeklogo.com.png', 'Petrobras', 'PETR4.SA'),
  ];
  Rxn<ItemDropdown> dropdownValue = Rxn<ItemDropdown>();
  RxBool loading = false.obs;

  @override
  void onInit() async {
    dropdownValue.value = itemsDropdown[0];
    super.onInit();
  }

  void changeDropdown(ItemDropdown itemDropdown){
    dropdownValue.value = itemDropdown;
    update();
  }

  void getData() async {
    RxBool loading = true.obs;
    chartData.clear();
    var data = await DataSource.fetchData(dropdownValue.value!.cod);
    values.value = data.values ?? [];
    for (var element in values) { 
      chartData.add(FlSpot(element.time.toDouble(), element.value.toDouble()));
    }
    loading = false.obs;
  }
}
