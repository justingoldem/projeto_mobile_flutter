import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe responsável por enviar requisições para adicionar produtos ao estoque
class apiServiceAdiciona {
  // URL base da API para o endpoint de produtos
  final String baseUrll = 'https://api-greenlife.onrender.com/produtos/';

  // Método assíncrono para adicionar produto com ID, nome e quantidade
  Future<http.Response> adicionarProduto(
      String id, String nome, int quantidade) async {
    // Constrói a URL completa adicionando o endpoint específico para o produto e a ação de adicionar
    final String apiUrll = '${baseUrll}${id}/adicionar-estoque';

    // Dados a serem enviados no corpo da requisição
    Map<String, dynamic> data = {
      'nome': nome,
      'quantidade': quantidade,
    };

    try {
      // Faz uma requisição POST para a API com cabeçalhos e corpo da requisição
      final response = await http.post(
        Uri.parse(apiUrll),  // Converte a URL para o formato URI
        headers: {
          'Content-Type': 'application/json', // Define o tipo de conteúdo como JSON
        },
        body: jsonEncode(data), // Converte o mapa de dados para JSON
      );

      return response; // Retorna a resposta da API para o chamador
    } catch (e) {
      // Lança uma exceção em caso de erro na conexão
      throw Exception('Erro de conexão: $e');
    }
  }
}
