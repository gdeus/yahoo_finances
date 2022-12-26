import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';
import 'package:intl/intl.dart';

class PercentsPage extends StatelessWidget {
  const PercentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    controller.getData();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Percentuais Ativos'),
        ),
        body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Dia',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Data',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Valor',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Variação diaria',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Variação ao 1º dia',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: controller.values
                      .map((value) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text((value.day + 1).toString())),
                              DataCell(Text(DateFormat('dd/MM/yyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      value.time.toInt() * 1000)))),
                              DataCell(Text(
                                  'R\$ ${value.value.toStringAsFixed(2)}')),
                              DataCell(value.day != 0
                                  ? Text(
                                      '${value.percentage.toStringAsFixed(1)}%')
                                  : const Text('-')),
                              DataCell(value.day != 0
                                  ? Text(
                                      '${value.percentaged1.toStringAsFixed(1)}%')
                                  : const Text('-')),
                            ],
                          ))
                      .toList()),
            ))));
  }
}
