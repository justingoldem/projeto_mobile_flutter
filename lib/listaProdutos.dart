import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProductListApp());
}

class ProductListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
 late Future<List<Map<String,dynamic>>> _productFuture;

@override
void initState(){
  super.initState();
  _productFuture = _initDatabaseAndLoadProducts();
}

Future<List<Map<String, dynamic>>> _initDatabaseAndLoadProducts() async {
  final database = await openDatabase (
     join (await getDatabasesPath() ,'products.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE products(id integer primary key, name text , codigo text)',
      );
    },
    version: 1,
  );
  final List<Map<String, dynamic>> existingProducts = await database.query('products');
  if (existingProducts.isEmpty) {
    await database.insert('products', {'Nome': 'Alface', 'Codigo ': '001' });
    await database.insert('products', {'Nome': 'Rucula', 'Codigo ': '002' });
    await database.insert('products', {'Nome': 'Alho Poro', 'Codigo ': '003' });
  }
  return await database.query('products');
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de produtos '),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>> (
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os produtos '));
          }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child:  Text('Nenhum produto disponivel '));
          }else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(product['nome']),
                    subtitle: Text(product['Codigo']),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            Nome: product['Nome'],
                            Codigo: product['Codigo'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String Nome;
  final String Codigo;

  ProductDetailPage({required this.Nome, required this.Codigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Nome),
      ),
      body: Center(
        child: Text(
          '$Nome custa $Codigo',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}





