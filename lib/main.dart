import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_variance_finance_app/presenter/chart_page.dart';
import 'package:yahoo_variance_finance_app/presenter/percents_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const App()),
      GetPage(name: '/chart', page: () => ChartPage()),
      GetPage(name: '/table', page: () => const PercentsPage()),
    ],
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: () {
                Get.toNamed("/chart");
              },
              child: const Text('Ver gráfico')),
          OutlinedButton(
              onPressed: () {
                Get.toNamed("/table");
              },
              child: const Text('Ver tabela')),
        ],
      ),
    ));
  }
}
