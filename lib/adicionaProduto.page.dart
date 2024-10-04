import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/apirequisicaoAdiciona.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';

class AdicionaProduto extends StatefulWidget {
  @override
  _AdicionaState createState() => _AdicionaState();
}

class _AdicionaState extends State<AdicionaProduto> {
  final apiServiceAdiciona apiService = apiServiceAdiciona();
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  Future<void> _adicionarProduto() async {
    String nomeProduto = _nomeProdutoController.text;
    String quantidadeStr = _quantidadeController.text;
    String idCodigo = _idController.text;

    if (nomeProduto.isEmpty || quantidadeStr.isEmpty || idCodigo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int quantidade = int.tryParse(quantidadeStr) ?? 0;

    try {
      final response = await apiService.adicionarProduto(
          idCodigo, nomeProduto, quantidade);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto adicionado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${response.statusCode} - ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo.png"),
            ),
            Text(
              'Adicionar Produto',
              style: GoogleFonts.playfairDisplay(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _idController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: getInputdecoration("Código"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nomeProdutoController,
              keyboardType: TextInputType.text,
              decoration: getInputdecoration("Nome do Produto"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: getInputdecoration("Quantidade"),
            ),
            SizedBox(height: 40),
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
                  onPressed: _adicionarProduto,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
