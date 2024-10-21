import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicao.dart';  // Importa a classe de requisição de API personalizada
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart'; // Importa o estilo de decoração para os campos de entrada
import 'package:google_fonts/google_fonts.dart'; // Importa o pacote para usar fontes personalizadas do Google

// Função principal que executa o aplicativo
void main() {
  runApp(ConsultaProduto());
}
// Classe principal do widget que é um estado mutável (StatefulWidget)
class ConsultaProduto extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}
// Estado do widget que gerencia os dados e interações do componente
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

  // Método padrão chamado ao iniciar o widget
  @override
  void initState() {
    super.initState();
  }
 // Método para consultar um produto na API
  void _consultaProduto() async {
    String nomeProduto = _nomeProdutoController.text.toLowerCase();

    try {
       // Faz a requisição à API para buscar os produtos
      var produtos = await apiService.getProdutos();
        // Procura o produto na lista pelo nome (case insensitive)
      var produtoEncontrado = produtos.firstWhere(
        (produto) => produto['Nome'].toLowerCase() == nomeProduto,
        orElse: () => Null,
      );
      // Se o produto for encontrado, atualiza o estado para exibir os detalhes  
      if (produtoEncontrado != Null) {
        setState(() {
          _mostraDetalhes = true; // Habilita a exibição dos detalhes
          _nomeProduto = produtoEncontrado['Nome'];
          _categoriaProduto = produtoEncontrado['Categoria'];
          _descricaoProduto = produtoEncontrado['Descricao'];
          _precoProduto = produtoEncontrado['Preco'].toStringAsFixed(2);
          _quantidadeProduto = produtoEncontrado['qtd_kg'].toString();
          _imagemProduto = produtoEncontrado['Imagem'];
        });
      }
    } catch (e) {
       // Em caso de erro, exibe uma mensagem na tela e habilita o controle de detalhes
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
   // Método que constrói a interface gráfica do widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Barra de navegação no topo
      ),
      body: SingleChildScrollView( // Permite que o conteúdo role
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo.png"),
            ),
            Text(
              'Consulta Produto',  // Título da tela
              style: GoogleFonts.playfairDisplay(  // Fonte personalizada
                  fontSize: 25, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 25), // Espaçamento vertical
            TextFormField(
              controller: _nomeProdutoController,
              keyboardType: TextInputType.text,
              decoration: getInputdecoration("Nome do Produto: "),  // Estilo de campo
            ),
            SizedBox(height: 15),
             // Botão de consulta
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient( // Gradiente do botão
                  begin: Alignment.topLeft, //Gradiente começa no topo esquerdo 
                  end: Alignment.bottomRight,// e termina no lado direito 
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(0, 100, 1, 50), 
                    Color.fromRGBO(0, 255, 0, 50),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)), // bodas arendondadas no botao 
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _consultaProduto, // Chama a função de consulta ao pressionar o botão
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Consultar Produto",  // Texto do botão
                        style: TextStyle(
                          fontWeight: FontWeight.bold, //fonte em negrito 
                          color: Colors.black, // corda fonte 
                          fontSize: 20, // tamanho da fonte 
                        ),
                        textAlign: TextAlign.left, //alinhamento com a coluna a esquerda 
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
             // Se o produto foi encontrado, exibe os detalhes
            if (_mostraDetalhes)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Nome do produto
                  Text(
                    _nomeProduto,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Exibe a imagem se o URL estiver disponível
                  if (_imagemProduto.isNotEmpty)
  Image.network(
    _imagemProduto,
    height: 150, // Altura da imagem
    width: 150,  // Largura da imagem
    errorBuilder: (context, error, stackTrace) {
      return Text('Imagem não disponível'); // Exibir caso a imagem não seja carregada
    },
  ),
                  // Categoria do produto
                  Text(
                    'Categoria: $_categoriaProduto',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                   // Preço do produto
                  Text(
                    'preco: R\$ $_precoProduto',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                   // Descrição do produto
                  Text(
                    'Descricao: $_descricaoProduto',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  // Quantidade disponível do produto
                  Text(
                    'Quantidade: $_quantidadeProduto kg',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
