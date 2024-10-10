import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicao.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ConsultaProduto());
}

class ConsultaProduto extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<ConsultaProduto> {
  final ApiService apiService = ApiService();
  final TextEditingController _nomeProdutoController = TextEditingController();
  bool _mostraDetalhes = false; // Controle para exibir os detalhes do produto
  String _nomeProduto = "";
  String _categoriaProduto = "";
  String _descricaoProduto = "";
  String _precoProduto = "";
  String _quantidadeProduto = "";
  String _imagemProduto = "";

  @override
  void initState() {
    super.initState();
  }

  void _consultaProduto() async {
    String nomeProduto = _nomeProdutoController.text.toLowerCase();

    try {
      var produtos = await apiService.getProdutos();
      var produtoEncontrado = produtos.firstWhere(
        (produto) => produto['Nome'].toLowerCase() == nomeProduto,
        orElse: () => Null,
      );

      if (produtoEncontrado != Null) {
        setState(() {
          _mostraDetalhes = true;
          _nomeProduto = produtoEncontrado['Nome'];
          _categoriaProduto = produtoEncontrado['Categoria'];
          _descricaoProduto = produtoEncontrado['Descricao'];
          _precoProduto = produtoEncontrado['Preco'].toStringAsFixed(2);
          _quantidadeProduto = produtoEncontrado['qtd_kg'].toString();
          _imagemProduto = produtoEncontrado['Imagem'];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar produto: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _mostraDetalhes = true;
      });
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo.png"),
            ),
            Text(
              'Consulta Produto',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Espaçamento lateral
              child: TextFormField(
                controller: _nomeProdutoController,
                keyboardType: TextInputType.text,
                decoration: getInputdecoration("Nome do Produto "),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Espaçamento lateral
              child: Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: _consultaProduto,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Consultar Produto",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            if (_mostraDetalhes)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24), // Espaçamento nas laterais e na parte superior/inferior
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green, // Cor da borda verde
                      width: 2, // Largura da borda
                    ),
                    borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                  ),
                  padding: EdgeInsets.all(16), // Espaçamento interno do Container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          _nomeProduto,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Fonte preta
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (_imagemProduto.isNotEmpty)
                        Center(
                          child: Image.network(
                            _imagemProduto,
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Text('Imagem não disponível');
                            },
                          ),
                        ),
                      SizedBox(height: 16),
                      Text(
                        'Categoria: $_categoriaProduto',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 5, 233, 32), // Fonte preta
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Preço: R\$ $_precoProduto',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Fonte preta
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Descrição: $_descricaoProduto',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Fonte preta
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Quantidade: $_quantidadeProduto kg',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Fonte preta
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
