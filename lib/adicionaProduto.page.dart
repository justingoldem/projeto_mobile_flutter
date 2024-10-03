import 'package:flutter/material.dart';
import 'package:projeto_mobile_flutter/componentes/campoDecoracao.dart';

void main() {
  runApp(Adicionaproduto());
}

class Adicionaproduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset("assets/logo.png"),
          ),
          Text(
            'Adicionar produto',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            autofocus: true,
            decoration: getInputdecoration("Nome do Produto: "),
          ),
         
         SizedBox(
            height: 15,
          ),
          TextFormField(
            keyboardType: TextInputType. number,
            decoration: getInputdecoration("Quantidade: "),
          )
        ]
      )
        )
    );
  }
}
