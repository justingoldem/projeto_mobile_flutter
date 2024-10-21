import 'dart:convert'; // Importa a biblioteca para converter JSON
import 'package:http/http.dart' as http; // Importa a biblioteca HTTP para fazer requisições

// Classe responsável por se comunicar com o serviço de API
class ApiService {
  // URL base da API onde os produtos estão hospedados
  final String baseUrl = "https://api-greenlife.onrender.com/produtos";

 // Método para obter a lista de produtos
  Future<List<dynamic>> getProdutos() async {
    try {  // Faz uma requisição GET à API
      final response = await http.get(Uri.parse('$baseUrl'));

      // Verifica se a requisição foi bem-sucedida (status 200)
      if (response.statusCode == 200) {
         // Decodifica o corpo da resposta (JSON) para um mapa
        var data = jsonDecode(response.body);
        // Retorna a primeira lista de produtos do campo 'recordsets'
        return data['recordsets'][0]; // Acessa a lista de produtos no JSON
      } else {
        // Se não for bem-sucedida, lança uma exceção com a mensagem de erro
        throw Exception('Erro ao buscar produtos');
      }
    } catch (e) {
      // Captura qualquer exceção e lança uma nova com a mensagem de erro
      throw Exception('Erro: $e');
    }
  }
}
