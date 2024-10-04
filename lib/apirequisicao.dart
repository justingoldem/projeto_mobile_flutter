import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api-greenlife.onrender.com/produtos";  

  Future<List<dynamic>> getProdutos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/produtos'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['recordsets'][0];  // Acessa a lista de produtos no JSON
      } else {
        throw Exception('Erro ao buscar produtos');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}