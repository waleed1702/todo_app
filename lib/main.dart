import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/home/ui_l_home_provider.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/login/ui_l_login.dart';
import 'package:todo_app/login/ui_login.dart';
import 'package:todo_app/home/ui_home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UILogicHome()),
        ChangeNotifierProvider(create: (context) => UILoginLogin()),
      ],
      child: MyApp(),
    ),
  );
}

loadData() async {
  SharedPreferences data = await SharedPreferences.getInstance();
  String? cachedata = data.getString('todo_list');
  return cachedata;
}

class MyApp extends StatelessWidget {
  String? data;
  MyApp({super.key}) {
    data = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.background),
        useMaterial3: true,
      ),
      initialRoute: data == null ? '/' : '/home',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
