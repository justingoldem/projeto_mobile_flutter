import 'package:projeto_mobile_flutter/produto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelp {
  static final Databasehelp _instance = Databasehelp._internal();
  factory Databasehelp() => _instance;

  static Database? _Database;

  Databasehelp._internal();

  Future<Database> get _database async {
    return _database!;
    _Database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE products(id INTEGEER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertProduct(Product product) async {
    final db = Database;
    await db.insert(
      'products',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProducts() async {
    final db = Database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product(
        Codigo: maps[i]['Codigo'],
        Nome: maps[i]['Nome'],
      );
    });
  }
}
