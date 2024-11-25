import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_mobile_flutter/adicionaProduto.page.dart';  // Importa a página de adicionar produto
import 'package:projeto_mobile_flutter/consultaProduto.page.dart'; // Importa a página de consulta de produto
import 'package:projeto_mobile_flutter/login.page.dart'; // Importa a página de login


// Classe MenuPage que é responsável por iniciar a tela principal do menu
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a tela inicial do app como MenuScreen
      home: MenuScreen(),
      // Remove o banner de debug que aparece no canto superior direito durante o desenvolvimento
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
          mainAxisAlignment: MainAxisAlignment.center,  // Centraliza os widgets verticalmente
          children: <Widget>[
            // Exibe o logo da aplicação
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/logo4.png"),
            ),
            SizedBox(height: 20),
            
            // Título do Menu
            Text(
              'Menu',  // Título da página
              style: GoogleFonts.playfairDisplay( // Usa a fonte Playfair Display do Google Fonts
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Botão para Adicionar Produto
            _buildGradientButton(
              context,
              label: 'Adicionar Produto',
              onPressed: () {
                // Navega para a tela de adicionar produto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdicionaProduto()),
                );
              },
            ),

            SizedBox(height: 25),

            // Botão para Consultar Produto
            _buildGradientButton(
              context,
              label: 'Consulta Produto',
              onPressed: () {
                // Navega para a tela de consulta de produto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaProduto()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir botões com gradiente e estilo personalizado
  Widget _buildGradientButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        // Define o gradiente de cores do botão
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 100, 1, 50),
            Color.fromRGBO(0, 255, 0, 50),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // Arredonda as bordas do botão
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          backgroundColor: Colors.transparent, // Mantém o fundo transparente para destacar o gradiente
          shadowColor: Colors.transparent, // Remove sombra para um gradiente mais limpo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black, // Cor do texto do botão
          ),
        ),
      ),
    );
  }
}
