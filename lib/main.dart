import 'package:projeto_mobile_flutter/login.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Green Life',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
    );
  }
}
