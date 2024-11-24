import 'package:projeto_mobile_flutter/login.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Green Life', // Título da aplicação
      debugShowCheckedModeBanner: false, // Desativa o banner de debug
      theme: ThemeData(primarySwatch: Colors.green), // Define o tema principal
      home: LoginPage(), // Define a página inicial
    );
  }
}
