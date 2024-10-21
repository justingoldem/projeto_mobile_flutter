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
      title: 'Mobile Green Life',  // Define o título do app
      debugShowCheckedModeBanner:false, // Remove a faixa de debug do canto da tela
      theme: ThemeData(primarySwatch: Colors.green), // Define o tema principal com cor verde
      home: LoginPage(),  // Define a tela inicial como a página de login
    );
  }
}
