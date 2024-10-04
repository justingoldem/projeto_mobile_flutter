import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  )
  );
}

class adicionaproduto extends StatefulWidget {
  @override
  _adicionaState createState() => _adicionaState();
}

class _adicionaState extends State<adicionaproduto> {
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  void _AdicionarProduto() {
    String nomeProduto = _nomeProdutoController.text;
    String quantidade = _quantidadeController.text;

    if (nomeProduto == "Alface"  && quantidade == "10") {

        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produto Enviado ao Estoque '),
          backgroundColor: Colors.green[600],
        ),
      );
    } else {
      // produto com erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Algun dado esta incorreto! '),
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
              'Adicionar produto',
               style: GoogleFonts.playfairDisplay(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                  ),
              ),
              
            
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _nomeProdutoController,
              keyboardType: TextInputType.name,
              autofocus: true,
              decoration: getInputdecoration("Nome do Produto: "),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: getInputdecoration("Quantidade: "),
            ),
            SizedBox(
              height: 40,
            ),
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
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _AdicionarProduto ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Enviar Produto ",
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
