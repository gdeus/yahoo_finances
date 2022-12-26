import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/commom_widgets/row_button.dart';
import 'package:yahoo_variance_finance_app/models/item_dropdown.dart';
import 'package:yahoo_variance_finance_app/presenter/controller.dart';

class HomePage extends StatelessWidget {
  MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(title: const Text('Tela inicial')),
          body: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Qual empresa deseja visualizar os dados da bolsa ?", 
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputDecorator(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: controller.dropdownValue.value,
                          items: controller.itemsDropdown.map((ItemDropdown item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(item.logo),
                                  Text(item.name)
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (ItemDropdown? newValue) {
                            controller.changeDropdown(newValue!);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: rowButton("Tabela", () => Get.toNamed('/table'), Icons.table_chart_outlined, const Color.fromARGB(255, 240, 15, 15), const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: rowButton("Gráfico", () => Get.toNamed('/chart'), Icons.bar_chart, const Color.fromARGB(255, 240, 15, 15), const Color.fromARGB(255, 0, 0, 0)),
                  )
                ],
          ),
        );
      }
    );
  }
}