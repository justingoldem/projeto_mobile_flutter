import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/menu.page.dart';

// Função principal que inicia o aplicativo e oculta a banner de debug
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

// Declaração da página de login como um StatefulWidget para possibilitar o uso de estado
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Estado da página de login
class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar o texto inserido nos campos de e-mail e senha
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função para processar o login
  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Verifica as credenciais de login
    if (email == "Admin" && password == "12345") {
      // Navega para a página de menu caso as credenciais estejam corretas
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(),
        ),
      );
    } else {
      // Mostra uma mensagem de erro caso o login falhe
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha incorretos!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            // Exibe o logo no topo
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/logo4.png'),
            ),
            SizedBox(height: 20),
            
            // Campo de e-mail
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            
            // Campo de senha
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true, // Oculta a senha
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            
            // Botão de Login com gradiente
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(0, 100, 1, 50),
                    Color.fromRGBO(0, 255, 0, 50),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _login,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: Image.asset("assets/entrar.png"),
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
