import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';

class ChartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    controller.getData();
    
    return Scaffold(
        body: Obx(() => controller.loading.value ? Center(child: CircularProgressIndicator(),) :  
            Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: LineChart(LineChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(axisNameWidget: const Text("Gráfico de variação de preço PETR4")),
                      leftTitles: AxisTitles(axisNameWidget: const Text("Valor")),
                      
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.chartData,
                        isCurved: true,
                        barWidth: 1,
                        color: Colors.amber,
                      ),
                    ],    // write your logic
                  ),
                  swapAnimationDuration: Duration(milliseconds: 150), 
                    // OptionalswapAnimationCurve: Curves.linear,
                    // Optional
                  ),
                )
        )
        );
  }
}
