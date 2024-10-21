import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicaoAdiciona.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';


class AdicionaProduto extends StatefulWidget {
  @override
  _AdicionaState createState() => _AdicionaState();
}
 //Classe que gerencia o estado do widget
class _AdicionaState extends State<AdicionaProduto> {
  // Instância do serviço de API para adicionar produtos
  final apiServiceAdiciona apiService = apiServiceAdiciona();
  // Controladores de texto para os campos de entrada do formulário
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
   final TextEditingController _idController = TextEditingController();

// Método para adicionar um produto, chamado ao pressionar o botão
  Future<void> _adicionarProduto() async {
     // Obtém os valores dos campos de texto
    String nomeProduto = _nomeProdutoController.text;
    String quantidadeStr = _quantidadeController.text;
    String idCodigo = _idController.text;

 // Verifica se os campos obrigatórios estão preenchidos
    if (nomeProduto.isEmpty || quantidadeStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
 // Converte a quantidade para inteiro, usando 0 como padrão se a conversão falhar
    int quantidade = int.tryParse(quantidadeStr) ?? 0;

    try {
       // Faz uma requisição à API para adicionar o produto
      final response = await apiService.adicionarProduto(
          idCodigo, nomeProduto, quantidade);

        // Verifica o status da resposta da API
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto adicionado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Exibe uma mensagem de erro se a requisição falhar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${response.statusCode} - ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Captura e exibe erros durante a requisição
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar produto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),// Barra de navegação
      body: Center( //Center foi colocado para a logo ficar Centralizado 
        child: Column( //Column serve para que cada item fique um em baixo do outro 
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo.png"), //adiciona a imageem 
            ),
             // titulo da pagina 
            Text( 
              'Adicionar Produto:',
              style: GoogleFonts.playfairDisplay( //fonte do google teve adicionar uma biblioteca para usar a fonte playfairdisplay
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            //espaco entre os objetos
             SizedBox(height: 20),
             // Campo de entrada para o código do produto
            TextFormField(
              controller: _idController,
              keyboardType: TextInputType.text,
              decoration: getInputdecoration("Codigo: "),
            ),
            SizedBox(height: 20),
            // Campo de entrada para o nome do produto
            TextFormField(
              controller: _nomeProdutoController,
              keyboardType: TextInputType.text,
              decoration: getInputdecoration("Nome do Produto "),
            ),
            SizedBox(height: 20),
              // Campo de entrada para a quantidade
            TextFormField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: getInputdecoration("Quantidade: "),
            ),
            SizedBox(height: 40),
             // Botão de enviar
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(0, 100, 1, 50), // cores do gradiente
                    Color.fromRGBO(0, 255, 0, 50),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _adicionarProduto, // Ao pressionar clicar passa pra proxima tela 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Enviar Produto",// Texto no botão
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
          ],
        ),
      ),
    );
  }
}
