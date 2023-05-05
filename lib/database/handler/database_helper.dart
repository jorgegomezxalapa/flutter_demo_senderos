import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //db info
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  //tabla personas
  static const table = 'personas';
  static const columnId = 'id';
  static const columnNombre = 'nombre';
  static const columnPrimerApellido = 'primer_apellido';
  static const columnSegundoApellido = 'segundo_apellido';
  static const columnEdad = 'edad';
  static const columnGenero = 'genero';

  //tabla paises
  static const tablePaises = 'paises';
  static const columnIdPais = 'id_pais';
  static const columnCommon = 'common';

  // Instancia singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Instancia de la base de datos
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    //await _onCreatePaises(_database!, _databaseVersion);
    return _database;
  }


  // Abre la base de datos
  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$_databaseName';
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Crea la tabla personas y la tabla paises
  Future _onCreate(Database db, int version) async {
    // Crea la tabla personas
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

    // Crea la tabla paises
    await _onCreatePaises(db, version);
  }

  // Crea la tabla paises
  Future _onCreatePaises(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tablePaises (
            $columnIdPais INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCommon TEXT NOT NULL,
            UNIQUE ($columnCommon)
          )
          ''');
  }

  // Inserta un registro en la tabla personas
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
  }

  //Inserta un registro en la tabla de paises
  Future<int?> insertPais(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tablePaises, row);
  }

  //Inserta varios registros en la tabla de paises
  Future<void> insertPaises(List<Map<String, dynamic>> rows) async {
    Database? db = await instance.database;
    Batch batch = db!.batch();
    for (var row in rows) {
      // Use the INSERT OR IGNORE statement to ignore any rows that would result in a conflict
      batch.insert(tablePaises, row, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> queryAllPaises() async {
    Database? db = await instance.database;
    return await db!.query(tablePaises);
  }




}