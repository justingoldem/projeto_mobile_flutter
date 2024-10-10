import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_mobile_flutter/adicionaProduto.page.dart';
import 'package:projeto_mobile_flutter/consultaProduto.page.dart';
import 'package:projeto_mobile_flutter/login.page.dart';
import 'package:projeto_mobile_flutter/removeProduto.page.dart';

void main() {
  runApp(MenuPage());
}



class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Menu',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
           Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromRGBO(0, 100, 1, 50),
               Color.fromRGBO(0, 255, 0, 50),], // Cores do gradiente
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12), // Bordas arredondadas
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      backgroundColor: Colors.transparent, // Importante: Deixe a cor de fundo transparente
      shadowColor: Colors.transparent, // Remove a sombra para exibir o gradiente limpo
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => AdicionaProduto()),
      );
    },
    child: Text(
      'Adicionar Produto',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black, // Cor do texto
      ),
    ),
  ),
),
SizedBox(height: 25),
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromRGBO(0, 100, 1, 50),
               Color.fromRGBO(0, 255, 0, 50),], // Cores do gradiente
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  
    borderRadius: BorderRadius.circular(12), // Bordas arredondadas
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      backgroundColor: Colors.transparent, // Importante: Deixe a cor de fundo transparente
      shadowColor: Colors.transparent, // Remove a sombra para exibir o gradiente limpo
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ConsultaProduto()),
      );
    },
    child: Text(
    'Consulta Produto',
   style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
