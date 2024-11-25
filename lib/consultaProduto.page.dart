import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicao.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';

// Função principal que inicia o app
void main() {
  runApp(ConsultaProduto());
}

// Declara a classe de widget Stateful para permitir atualização de estado
class ConsultaProduto extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}

// Define o estado do widget, incluindo variáveis e lógica de busca do produto
class _ConsultaState extends State<ConsultaProduto> {
  // Instancia ApiService para acessar a API de produtos
  final ApiService apiService = ApiService();

  // Controlador para capturar o nome do produto inserido pelo usuário
  final TextEditingController _nomeProdutoController = TextEditingController();

  // Variáveis de controle e dados do produto
  bool _mostraDetalhes = false;
  String _nomeProduto = "";
  String _categoriaProduto = "";
  String _descricaoProduto = "";
  String _precoProduto = "";
  String _quantidadeProduto = "";
  String _imagemProduto = "";

  // Função que faz a consulta do produto
  void _consultaProduto() async {
    String nomeProduto = _nomeProdutoController.text.toLowerCase();

    try {
      // Obtém a lista de produtos usando a API e filtra pelo nome
      var produtos = await apiService.getProdutos();
      var produtoEncontrado = produtos.firstWhere(
        (produto) => produto['Nome'].toLowerCase() == nomeProduto,
        orElse: () => Null,
      );

      // Se o produto foi encontrado, atualiza os detalhes no estado
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
      // Exibe mensagem de erro em caso de falha na requisição
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar produto: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _mostraDetalhes = false;
      });
    }
  }

  // Constrói a interface da aplicação
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Exibe um logo da aplicação
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo4.png"),
            ),
            // Título da tela
            Text(
              'Consulta Produto',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 25),
            // Campo de texto para o usuário digitar o nome do produto
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _nomeProdutoController,
                keyboardType: TextInputType.text,
                decoration: getInputdecoration("Nome do Produto "),
              ),
            ),
            SizedBox(height: 15),
            // Botão para consultar o produto
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
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
            // Exibe detalhes do produto se encontrado
            if (_mostraDetalhes)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          _nomeProduto,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                          color: const Color.fromARGB(255, 5, 233, 32),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Preço: R\$ $_precoProduto',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Descrição: $_descricaoProduto',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Quantidade: $_quantidadeProduto kg',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}