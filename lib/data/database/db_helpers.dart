import '../../core.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableNameItem (
            kode_sku TEXT PRIMARY KEY,
            nama_barang TEXT,
            foto TEXT,
            quantity INTEGER,
            price REAL
          )
        ''');

        await db.execute('''
        CREATE TABLE $tableNameUser (
          email TEXT PRIMARY KEY,
          name TEXT,
          phone TEXT,
          password TEXT
        )
      ''');

        await insertDummyData(db);
      },
    );
  }

  Future<void> insertDummyData(Database db) async {
    List<Map<String, dynamic>> dummyData = [
      {
        'kode_sku': 'SKU001',
        'nama_barang': 'Laptop Asus',
        'foto': AssetsHelper.imgAsus,
        'quantity': 10,
        'price': 15000000.0
      },
      {
        'kode_sku': 'SKU002',
        'nama_barang': 'Smartphone Samsung',
        'foto': AssetsHelper.imgHP,
        'quantity': 15,
        'price': 8000000.0
      },
      {
        'kode_sku': 'SKU003',
        'nama_barang': 'Smartwatch Apple',
        'foto': AssetsHelper.imgJam,
        'quantity': 5,
        'price': 7000000.0
      },
      {
        'kode_sku': 'SKU004',
        'nama_barang': 'Headset Sony',
        'foto': AssetsHelper.imgHeadset,
        'quantity': 20,
        'price': 2000000.0
      },
      {
        'kode_sku': 'SKU005',
        'nama_barang': 'Keyboard Mechanical',
        'foto': AssetsHelper.imgKeyboard,
        'quantity': 12,
        'price': 1000000.0
      },
    ];

    for (var item in dummyData) {
      await db.insert(tableNameItem, item);
    }
  }

  Future<int> createItem(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert(tableNameItem, item);
  }

  Future<List<Map<String, dynamic>>> readItems() async {
    final db = await database;
    return await db.query(tableNameItem);
  }

  Future<int> updateItem(String kodeSku, Map<String, dynamic> item) async {
    final db = await database;
    return await db.update(tableNameItem, item,
        where: 'kode_sku = ?', whereArgs: [kodeSku]);
  }

  Future<int> deleteItem(String kodeSku) async {
    final db = await database;
    return await db
        .delete(tableNameItem, where: 'kode_sku = ?', whereArgs: [kodeSku]);
  }

  Future<List<Map<String, dynamic>>> searchItems(String query) async {
    final db = await database;
    return await db.query(tableNameItem,
        where: 'nama_barang LIKE ?', whereArgs: ['%$query%']);
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert(tableNameUser, userData);
  }

  Future<Map<String, dynamic>?> getUserByEmailOrPhone(
      String emailOrPhone) async {
    final db = await database;
    final result = await db.query(
      tableNameUser,
      where: 'email = ? OR phone = ?',
      whereArgs: [emailOrPhone, emailOrPhone],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
