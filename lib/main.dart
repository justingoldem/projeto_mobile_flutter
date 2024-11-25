import 'package:projeto_mobile_flutter/login.page.dart'; // Importa a página de login do projeto
import 'package:flutter/material.dart'; // Importa os componentes básicos de UI do Flutter

// Função principal que inicia o app
void main() => runApp(MyApp()); // Executa o app chamando a classe MyApp

// Define a classe MyApp como um widget sem estado (StatelessWidget)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // Função build que retorna a estrutura da interface
    return MaterialApp(
      title: 'Mobile Green Life', // Título da aplicação
      debugShowCheckedModeBanner: false, // Desativa o banner de debug
      theme: ThemeData(primarySwatch: Colors.green), // Define o tema principal
      home: LoginPage(), // Define a página inicial
    );
  }
}
