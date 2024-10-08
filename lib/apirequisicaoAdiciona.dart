import 'package:http/http.dart' as http;
import 'dart:convert';

class apiServiceAdiciona {
  final String baseUrll = 'https://api-greenlife.onrender.com/produtos/';

  Future<http.Response> adicionarProduto(
      String id, String nome, int quantidade) async {
    // Constrói a URL completa usando interpolação de strings
    final String apiUrll = '${baseUrll}${id}/adicionar-estoque';

    Map<String, dynamic> data = {
      'nome': nome,
      'quantidade': quantidade,
    };

    try {
      // Faz a requisição POST para a API
      final response = await http.post(
        Uri.parse(apiUrll),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      return response; // Retorna a resposta da API
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
