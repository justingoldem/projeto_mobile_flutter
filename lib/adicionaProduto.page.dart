import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicaoAdiciona.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';

// Define um widget com estado chamado AdicionaProduto
class AdicionaProduto extends StatefulWidget {
  @override
  _AdicionaState createState() => _AdicionaState();
}

// Classe responsável pelo estado do widget AdicionaProduto
class _AdicionaState extends State<AdicionaProduto> {
  // Instanciação do serviço de API para adicionar produtos
  final apiServiceAdiciona apiService = apiServiceAdiciona();

  // Controladores de texto para os campos de entrada
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  // Função assíncrona para adicionar um produto
  Future<void> _adicionarProduto() async {
    // Recupera os valores dos controladores de texto
    String nomeProduto = _nomeProdutoController.text;
    String quantidadeStr = _quantidadeController.text;
    String idCodigo = _idController.text;

    // Validação dos campos
    if (nomeProduto.isEmpty || quantidadeStr.isEmpty) {
      // Mostra uma mensagem de erro se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Sai da função se houver campos vazios
    }

    // Converte a quantidade de texto para inteiro
    int quantidade = int.tryParse(quantidadeStr) ?? 0;

    try {
      // Chama o método adicionarProduto do serviço de API e passa os dados
      final response = await apiService.adicionarProduto(
          idCodigo, nomeProduto, quantidade);

      // Verifica a resposta da API
      if (response.statusCode == 200) {
        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto adicionado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Exibe uma mensagem de erro com o status e o corpo da resposta
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${response.statusCode} - ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Captura erros ao adicionar produto e exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar produto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método build para criar a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Barra de navegação
      body: Center(
        child: Column(
          children: <Widget>[
            // Imagem do logo
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo4.png"),
            ),
            // Texto de título
            Text(
              'Adicionar Produto:',
              style: GoogleFonts.playfairDisplay( //fonte do google teve adicionar uma biblioteca para usar a fonte playfairdisplay
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20), // Espaçamento

            // Campo de entrada para código do produto
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
              controller: _idController,
              keyboardType: TextInputType.text,
              decoration: getInputdecoration("Codigo: "),
            ),
             ),
            SizedBox(height: 20),

            // Campo de entrada para nome do produto
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _nomeProdutoController,
                keyboardType: TextInputType.text,
                decoration: getInputdecoration("Nome do Produto "),
              ),
            ),
            SizedBox(height: 20),

            // Campo de entrada para a quantidade do produto
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: getInputdecoration("Quantidade: "),
              ),
            ),
            SizedBox(height: 40),

            // Botão para enviar o produto
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
                      Color.fromRGBO(0, 100, 1, 50), // Cor inicial do gradiente
                      Color.fromRGBO(0, 255, 0, 50), // Cor final do gradiente
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)), // Borda arredondada
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: _adicionarProduto, // Função chamada ao clicar
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Texto no botão
                        Text(
                          "Enviar Produto",
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
          ],
        ),
      ),
    );
  }
}
