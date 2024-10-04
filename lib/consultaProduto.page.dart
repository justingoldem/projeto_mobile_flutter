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
  List<dynamic> produtos = [];
  bool isloading = true;
  final TextEditingController _nomeProdutoController = TextEditingController();
  bool _mostraDetalhes = false; // Controle para exibir os detalhes do produto
  String _nomeProduto = ""; // Nome do produto para exibir detalhes
  String _quantidadeProduto = ""; // Quantidade do produto para exibir detalhes

  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  Future<void> _fetchProdutos() async {
    try {
      var fetchedProdutos = await apiService.getProdutos();
      setState(() {
        produtos = fetchedProdutos;
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos: $e')),
      );
    }
  }

  void _consultaProduto() {
    String nomeProduto = _nomeProdutoController.text.toLowerCase();

    var produtoEncontrado = produtos.firstWhere(
      (produto) => produto['nome'].toLowerCase() == nomeProduto,
      orElse: () => null,
    );

    if (produtoEncontrado != null) {
      setState(() {
        _mostraDetalhes = true;
        _nomeProduto = produtoEncontrado['nome'];
        _quantidadeProduto = produtoEncontrado['qtd_kg'].toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produto Não está em Estoque'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _mostraDetalhes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Produto"),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                  TextFormField(
                    controller: _nomeProdutoController,
                    keyboardType: TextInputType.name,
                    autofocus: true,
                    decoration: getInputdecoration("Nome do Produto: "),
                  ),
                  SizedBox(height: 15),
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
                  SizedBox(height: 50),
                  if (_mostraDetalhes)
                    Column(
                      children: [
                      
                        Text(
                          _nomeProduto,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Quantidade: $_quantidadeProduto',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  SizedBox(height: 25),
                  Text(
                    'Lista de Produtos',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      var produto = produtos[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(produto['imagem']),
                          title: Text(produto['nome']),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Categoria: ${produto['Categoria']}'),
                                Text('Descrição: ${produto['Descrição']}'),
                                Text(
                                    'Preço: r\$ ${produto['Preço'].toStringAsFixed(2)}'),
                                Text('Quantidade: ${produto['qtd_kg']} kg'),
                              ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

