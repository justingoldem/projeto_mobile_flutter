import 'dart:convert'; // Importa a biblioteca para converter JSON
import 'package:http/http.dart' as http; // Importa a biblioteca HTTP para fazer requisições

// Define a classe ApiService que será responsável por gerenciar as requisições de API
class ApiService {
  // Define a URL base para acessar a API
  final String baseUrl = "https://api-greenlife.onrender.com/produtos";

  // Método assíncrono para buscar a lista de produtos da API
  Future<List<dynamic>> getProdutos() async {
    try {
      // Realiza uma requisição GET à URL definida
      final response = await http.get(Uri.parse('$baseUrl'));

      // Verifica se o código de status é 200 (requisição bem-sucedida)
      if (response.statusCode == 200) {
        // Decodifica o JSON da resposta para um objeto Dart
        var data = jsonDecode(response.body);

        // Acessa a primeira lista de produtos no JSON (usando 'recordsets')
        return data['recordsets'][0];
      } else {
        // Caso o status não seja 200, lança uma exceção com uma mensagem de erro
        throw Exception('Erro ao buscar produtos');
      }
    } catch (e) {
      // Captura e lança qualquer erro que ocorra durante a requisição
      throw Exception('Erro: $e');
    }
  }
}
