import 'package:flutter/material.dart';
import 'package:http_error_handling/screens/detail_screen.dart';
import 'package:http_error_handling/screens/main_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.routeName,
      routes: {
        '/': (context) => MainScreen(),
        '/detail': (context) => DetailScreen(),
      },
    );
  }
}
