import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe responsável por adicionar um produto ao estoque por meio de uma requisição HTTP POST
class apiServiceAdiciona {
   // URL base da API
  final String baseUrll = 'https://api-greenlife.onrender.com/produtos/';

  // Método para adicionar produto ao estoque, recebendo o ID, nome e quantidade como parâmetros
  Future<http.Response> adicionarProduto(
      String id, String nome, int quantidade) async {
    // Constrói a URL completa usando interpolação de strings
    final String apiUrll = '${baseUrll}${id}/adicionar-estoque';

    // Cria um mapa com os dados que serão enviados no corpo da requisição  
    Map<String, dynamic> data = {
      'nome': nome,
      'quantidade': quantidade,
    };

    try {
      // Faz a requisição POST para a API
      final response = await http.post(
        Uri.parse(apiUrll),  // Converte a URL para o formato URI
        headers: {
          'Content-Type': 'application/json', // Define o tipo de conteúdo como JSON
        },
        body: jsonEncode(data),  // Converte o mapa 'data' para JSON e envia no corpo da requisição
      );

      return response; // Retorna a resposta da API
    } catch (e) {
      throw Exception('Erro de conexão: $e');  // Em caso de erro na conexão, lança uma exceção com a mensagem de erro
    }
  }
}
