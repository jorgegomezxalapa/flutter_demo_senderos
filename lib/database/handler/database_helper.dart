import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  static const table = 'personas';

  static const columnId = 'id';
  static const columnNombre = 'nombre';
  static const columnPrimerApellido = 'primer_apellido';
  static const columnSegundoApellido = 'segundo_apellido';
  static const columnEdad = 'edad';
  static const columnGenero = 'genero';

  // Instancia singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Instancia de la base de datos
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // Abre la base de datos
  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$_databaseName';
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Crea la tabla personas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNombre TEXT NOT NULL,
            $columnPrimerApellido TEXT NOT NULL,
            $columnSegundoApellido TEXT NOT NULL,
            $columnEdad INTEGER NOT NULL,
            $columnGenero TEXT NOT NULL
          )
          ''');
  }

  // Inserta un registro en la tabla personas
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
  }
}