import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';
import 'package:intl/intl.dart';

class PercentsPage extends StatelessWidget {
  const PercentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    controller.getData();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Percentuais Ativos'),
        ),
        body: Obx(() => SingleChildScrollView(
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
                  ],
                  rows: controller.values
                      .map((e) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(e.day.toString())),
                              DataCell(Text(
                                  '${DateFormat('dd/MM/yyy').format(DateTime.fromMillisecondsSinceEpoch(e.time * 1000))}')),
                              DataCell(Text('${e.value.toDouble().roundToDouble()}')),
                              
                          
                            ],
                          ))
                      .toList()),
            )));
  }
}
