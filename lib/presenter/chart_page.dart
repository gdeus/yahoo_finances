import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    controller.getData();

    return Scaffold(
      appBar: AppBar(title: const Text('Gráfico')),
        body: Obx(() => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                          axisNameWidget: Text(
                              "Gráfico de variação de preço ${controller.dropdownValue.value!.name}")),
                      leftTitles:
                          AxisTitles(axisNameWidget: const Text("Valor")),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                var data = DateFormat('d/MM').format(DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000));
                                return Text(data);
                              }))),
                  lineBarsData: [
                    LineChartBarData(
                      spots: controller.chartData,
                      isCurved: true,
                      barWidth: 1,
                      color: Colors.amber,
                    ),
                  ],
                ),
                swapAnimationDuration: const Duration(milliseconds: 300),
              ),
            )));
  }
}
