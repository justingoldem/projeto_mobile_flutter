import 'package:flutter/material.dart';

class Product {
  final String Codigo;
  final String Nome;

  Product({required this.Codigo, required this.Nome });

  Map<String, dynamic> toMap() {
    return {
      'Codigo': Codigo,
      'Nome': Nome,
    };
  }

  @override
  String toString() {
    return 'Produto{codigo: $Codigo, Nome: $Nome}';
  }
}
