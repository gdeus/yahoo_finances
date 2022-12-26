import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';
import 'dart:math' as math;

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    controller.getData();

    List<Color> gradientColors = [
      Colors.greenAccent.shade100,
      Colors.greenAccent.shade200,
      Colors.greenAccent.shade400,
    ];

    const axisNameStyle = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gráfico'),
          backgroundColor: Colors.greenAccent,
        ),
        body: Obx(() => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white12,
                          strokeWidth: 1,
                        );
                      }),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                              axisNameWidget: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  "Gráfico de variação de preço ${controller.dropdownValue.value!.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              axisNameSize: 45),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                            getTitlesWidget: (value, meta) {
                              Widget axisTitle = Text(value.toStringAsFixed(1));

                              if (value == meta.max) {
                                final remainder = value % meta.appliedInterval;
                                if (remainder != 0.0 &&
                                    remainder / meta.appliedInterval < 0.5) {
                                  axisTitle = const SizedBox.shrink();
                                }
                              }

                              return SideTitleWidget(
                                  axisSide: meta.axisSide, child: axisTitle);
                            },
                          )),
                          leftTitles: AxisTitles(
                              axisNameWidget: const Text('Valor',
                                  style: axisNameStyle,
                                  textAlign: TextAlign.center),
                              axisNameSize: 30),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  reservedSize: 40,
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    var data = DateFormat('d/MM').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            value.toInt() * 1000));

                                    Widget axisTitle = Transform.rotate(
                                        angle: 45,
                                        child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            )));

                                    if (value == meta.max) {
                                      final remainder =
                                          value % meta.appliedInterval;
                                      if (remainder != 0.0 &&
                                          remainder / meta.appliedInterval <
                                              0.5) {
                                        axisTitle = const SizedBox.shrink();
                                      }
                                    }
                                    return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: axisTitle);
                                  }))),
                      lineBarsData: [
                        LineChartBarData(
                          gradient: LinearGradient(
                            colors: [
                              ColorTween(
                                      begin: gradientColors[0],
                                      end: gradientColors[1])
                                  .lerp(0.2)!,
                              ColorTween(
                                      begin: gradientColors[0],
                                      end: gradientColors[1])
                                  .lerp(0.2)!,
                            ],
                          ),
                          spots: controller.chartData,
                          isCurved: false,
                          isStrokeCapRound: true,
                          barWidth: 5,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.1))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 300),
                  ),
                ),
              )));
  }
}
