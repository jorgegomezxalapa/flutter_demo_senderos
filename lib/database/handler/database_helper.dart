import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //db
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

  //tabla inspecciones
  static const tableInspecciones = 'inspecciones';
  static const columnIdInspeccion = 'id';
  static const columnNoExpediente = 'no_expediente';
  static const columnFechaInspeccion = 'fecha_inspeccion';
  static const columnNombreRazonSocial = 'nombre_razon_social';
  static const columnDomicilio = 'domicilio';
  static const columnSubtipoActuacion = 'subtipo_actuacion';
  static const columnMateria = 'materia';
  static const columnAlcance = 'alcance';
  static const columnInspectorAsignado = 'inspector_asignado';
  static const columnEstatus = 'estatus';

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
        version: _databaseVersion,
        onCreate: _onCreate,
        onOpen: (db) async {

          // Verifica si la tabla personas existe
          var personasTableExists = await db.rawQuery(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='$table'");
          // Si no existe, crea la tabla personas
          if (personasTableExists.isEmpty) {

            await _onCreatePersonas(db, _databaseVersion);
          }
          // Verifica si la tabla paises existe
          var paisesTableExists = await db.rawQuery(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='$tablePaises'");
          // Si no existe, crea la tabla paises
          if (paisesTableExists.isEmpty) {
            await _onCreatePaises(db, _databaseVersion);
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < newVersion) {
            await db.execute(
              'CREATE TABLE inspecciones (id TEXT, no_expediente TEXT, fecha_inspeccion DATE, nombre_razon_social TEXT, domicilio TEXT, subtipo_actuacion TEXT, materia TEXT, alcance TEXT, inspector_asignado TEXT, estatus TEXT)',
            );
            // Insert some records in a transaction
            await db.transaction((txn) async {
              await txn.rawInsert('INSERT INTO inspecciones(id,no_expediente,fecha_inspeccion,nombre_razon_social,domicilio,subtipo_actuacion,materia,alcance,inspector_asignado,estatus) VALUES("1","EXP00001","2023-03-27","sindicato de Trabajadores de la Industria de la Construcci\u00f3n en General, Similares y Conexos del Estado de Tabasco, Registro","BLVD. CLUB DE GOLF BELLAVISTA NUMERO 14","Subtipo de actuaci\u00f3n 0","Materia 0","Alcance 0","Nombre inspector 0","1"),("2","EXP00002","2023-04-16","SINDICATO NACIONAL DE TRABAJADORES DE FORD MOTOR COMPANY Y DE LA INDUSTRIA AUTOMOTRIZ C.T.M,","PROLONGACION XICOTENCATL 2160","Subtipo de actuaci\u00f3n 1","Materia 1","Alcance 1","Nombre inspector 1","1"),("3","EXP00003","2023-04-12","SINDICATO DE TRABAJADORES Y EMPLEADOS DE AUTOTRANSPORTES DE SERVICIO P\u00daBLICO SIMILARES Y CONEXOS DEL ESTADO DE CAMPECHE","Ignacio L. Rayon 713","Subtipo de actuaci\u00f3n 2","Materia 2","Alcance 2","Nombre inspector 2","1")');
            });
          }
        },
        );

  }


  // Crea la tabla personas y la tabla paises
  Future _onCreate(Database db, int version) async {

    // Crea la tabla personas
    await _onCreatePersonas(db, version);
    // Crea la tabla paises
    await _onCreatePaises(db, version);
  }

  // Crea la tabla paises y luego inserta los registros iniciales
  Future _onCreatePaises(Database db, int version) async {

    // Crea la tabla paises
    await db.execute('''
    CREATE TABLE $tablePaises (
      $columnIdPais INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnCommon TEXT NOT NULL,
      UNIQUE ($columnCommon)
    )
  ''');

    // Crea una lista de mapas con los datos de los países a insertar
    List<Map<String, dynamic>> paises = [
      {DatabaseHelper.columnCommon: 'México Local'},
      {DatabaseHelper.columnCommon: 'Estados Unidos Local'},
      {DatabaseHelper.columnCommon: 'Canadá Local'}
    ];

    // Inserta cada país en la tabla paises
    for (var pais in paises) {

      await db.insert(tablePaises, pais);
    }
  }

  // Crea la tabla paises
  Future _onCreatePersonas(Database db, int version) async {

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

  //Obtiene el listado de paises de la tabla paises
  Future<List<Map<String, dynamic>>> queryAllPaises() async {
    Database? db = await instance.database;
    return await db!.query(tablePaises);
  }

  //Inserta varios registros en la tabla de inspecciones
  Future<void> insertInspecciones(List<Map<String, dynamic>> rows) async {
    Database? db = await instance.database;
    Batch batch = db!.batch();
    for (var row in rows) {
      // Use the INSERT OR IGNORE statement to ignore any rows that would result in a conflict
      batch.insert(tableInspecciones, row, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit();
  }

  //Inserta un registro en la tabla de inspecciones
  Future<int?> insertInspeccion(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tableInspecciones, row);
  }


  Future<List<Map<String, dynamic>>> queryAllInspecciones() async {
    Database? db = await instance.database;
    return await db!.query(tableInspecciones);
  }
}