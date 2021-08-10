import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_weather/Pages/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: HomePage(), initialRoute: '/',
        // передаём маршруты в приложение
        getPages: [
          GetPage(name: '/Home', page: () => HomePage()),
          //  GetPage(name: '/Home/detail', page: () => Detail()),
        ]);
  }
}
