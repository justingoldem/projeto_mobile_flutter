import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_mobile_flutter/adicionaProduto.page.dart';  // Importa a página de adicionar produto
import 'package:projeto_mobile_flutter/consultaProduto.page.dart'; // Importa a página de consulta de produto
import 'package:projeto_mobile_flutter/login.page.dart'; // Importa a página de login


void main() {
  runApp(MenuPage()); // Define que a tela inicial será a MenuPage
}
// MenuPage é um widget sem estado (StatelessWidget)
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),  // Define a MenuScreen como a tela principal
      debugShowCheckedModeBanner: false,
    );
  }
}
// MenuScreen define a tela de menu com várias opções
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centraliza os widgets verticalmente
          children: <Widget>[
            SizedBox(
              width: 200, // Largura da logo
              height: 200, // Altura da logo
              child: Image.asset("assets/logo.png"), // Exibe uma imagem localizada em "assets"
            ),
            SizedBox( // Espaçamento vertical
              height: 20,
            ),
            Text(
              'Menu',  // Título da página
              style: GoogleFonts.playfairDisplay( // Usa a fonte Playfair Display do Google Fonts
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
              // Botão para adicionar produto
            ElevatedButton(
              onPressed: () {  // Ao pressionar, navega para a tela de AdicionaProduto
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdicionaProduto()));
              },
              child: Text(
                'Adicionar Produto', // Texto do botão
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 25,
            ),
              // Botão para consultar produto
            ElevatedButton(
              onPressed: () { // Ao pressionar, navega para a tela de ConsultaProduto
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConsultaProduto()));
              },
              child: Text(
                'Consulta Produto', // Texto do botão
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 25,
            ),
              // Botão para fazer logout e voltar para a tela de login
            ElevatedButton(
              onPressed: () { // Ao pressionar, navega para a tela de LoginPage
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Logout', // Texto do botão
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
