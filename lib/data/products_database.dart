import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDatabase {
  static final ProductsDatabase instance = ProductsDatabase._init();

  static Database? _database;

  ProductsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb(); 
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            price REAL NOT NULL,
            image TEXT NOT NULL,
            rate REAL NOT NULL,
            count INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await instance.database;
    await db.insert(
      'products',
      {
        'id': product['id'],
        'title': product['title'],
        'description': product['description'],
        'price': (product['price'] as num).toDouble(),
        'image': product['image'],
        'rate': (product['rating']['rate'] as num).toDouble(),
        'count': product['rating']['count'],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await instance.database;
    return await db.query('products');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
