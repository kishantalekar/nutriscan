import 'package:nutriscan/features/customer/model/food_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'food_items.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        expiryDate TEXT,
        quantity INTEGER,
        photoPath TEXT
      )
    ''');
  }

  Future<int> insertFoodItem(FoodItem item) async {
    final db = await database;
    int id = await db.insert(
      'food_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<FoodItem>> getFoodItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_items');
    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  Future<void> deleteFoodItem(int id) async {
    final db = await database;
    await db.delete(
      'food_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
