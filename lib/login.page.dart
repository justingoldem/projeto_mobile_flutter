import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/menu.page.dart'; // Importa a página de menu que será acessada após o login

// Função principal que executa o app com MaterialApp e desabilita a marca de debug
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}
// Define a página de login como um widget com estado (StatefulWidget)
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
// Classe que gerencia o estado do LoginPage
class _LoginPageState extends State<LoginPage> {
  // Controladores de texto para os campos de e-mail e senha
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// Função que realiza o login ao ser chamada
  void _login() {
    String email = _emailController.text; // Captura o texto do campo de e-mail
    String password = _passwordController.text; // Captura o texto do campo de e-mail

   // Verifica se o e-mail e a senha são válidos (admin)
    if (email == "Admin" && password == "12345") {
      // Se for válido, navega para a página do Menu
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(), // Direciona para a página MenuPage
        ),
      );
    } else {
      // Login falhou
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha incorretos!'), // Mensagem de erro
          backgroundColor: Colors.red, // Cor de fundo do aviso
        ),
      );
    }
  }
  // Método que constrói a interface da página de login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Corpo da interface com um container centralizado
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40), // Define padding
        color: Colors.white,  // Define a cor de fundo branca
        child: ListView(   // Usa ListView para permitir rolagem da tela
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
             // Campo de entrada para o e-mail
            TextFormField(
              controller: _emailController, // Controlador para o campo de e-mail
              keyboardType: TextInputType.emailAddress, // Define o tipo de teclado
              autofocus: true, // Define o foco inicial no campo de e-mail
              decoration: InputDecoration(
                labelText: "E-mail:", // Label para o campo de e-mail
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20), // Define o estilo do texto no campo
            ),
            SizedBox(
              height: 10,
            ),
             // Campo de entrada para a senha
            TextFormField(
              controller: _passwordController, // Controlador para o campo de senha
              keyboardType: TextInputType.text, // Define o tipo de texto
              obscureText: true, // Esconde o texto inserido (senha)
              decoration: InputDecoration(
                labelText: "Senha:", // Label para o campo de senha
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
           
            SizedBox(
              height: 40,
            ),
            // Botão de login
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(  // Gradiente aplicado ao fundo do botão
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1], // Posição dos pontos de cor no gradiente
                  colors: [
                    Color.fromRGBO(0, 100, 1, 50),
                    Color.fromRGBO(0, 255, 0, 50),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5), // Bordas arredondadas do botão
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _login, // Chama a função de login ao pressionar o botão
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Texto "Login" no botão
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                       // Ícone de "entrar" ao lado do texto
                      Container(
                        child: Image.asset("assets/entrar.png"), // Imagem de ícone para o botão
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
