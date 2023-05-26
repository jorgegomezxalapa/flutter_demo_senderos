import 'package:sqflite/sqflite.dart';
//Paquete air_senderos
import 'package:air_senderos/database/models/credencial.dart';
import 'dart:convert';

class DatabaseHelper {
  //db
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  //tabla credenciales
  static const tableCredenciales = 'credenciales';
  static const columnCredencialId = 'id';
  static const columnCredencialUserCoreId = 'user_core_id';
  static const columnCredencialActivo = 'activo';
  static const columnCredencialNombre = 'nombre';
  static const columnCredencialPrimerApellido = 'primer_apellido';
  static const columnCredencialSegundoApellido = 'segundo_apellido';
  static const columnCredencialUsuario = 'usuario';
  static const columnCredencialPassword = 'password';
  static const columnCredencialToken = 'token';
  //tabla personas
  static const tablePersonas = 'personas';
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
  //tabla notificaciones
  static const tableNotificacion = 'notificacion';
  static const columnNotificacionId = 'notificacion_id';
  static const columnTipoDocumentoIdNotificacion = 'tipo_documento_id';
  static const columnInspectorIdNotificacion = 'inspector_id';
  static const columnInspeccionIdNotificacion = 'inspeccion_id';
  static const columnNotifMotivoNoEntregaIdNotificacion =
      'notif_motivo_no_entrega_id';
  static const columnNotifFormaConstatacionIdNotificacion =
      'notif_forma_constatacion_id';
  static const columnNotifEstatusAsignacionNotificacion =
      'notif_estatus_asignacion';
  static const columnNotifFormaEntregaNotificacion = 'notif_forma_entrega';
  static const columnNotifFormaEnvioNotificacion = 'notif_forma_envio';
  static const columnNotifFecLimiteEntregaNotificacion =
      'notif_fec_limite_entrega';
  static const columnNotifHoraLimiteRecepcionNotificacion =
      'notif_hora_limite_recepcion';
  static const columnNotifNotificacionPersonalNotificacion =
      'notif_notificacion_personal';
  static const columnNotifFecEnvioNotificacion = 'notif_fec_envio';
  static const columnNotifNumGuiaNotificacion = 'notif_num_guia';
  static const columnNotifFecEntregaProgramadaNotificacion =
      'notif_fec_entrega_programada';
  static const columnNotifEstatusEntregaNotificacion = 'notif_estatus_entrega';
  static const columnNotifSeRecibioNotificacion = 'notif_se_recibio';
  static const columnNotifQuedoPegadoNotificacion = 'notif_quedo_pegado';
  static const columnNotifOtroMotivoNotificacion = 'notif_otro_motivo';
  static const columnNotifFecEntregaNotificacion = 'notif_fec_entrega';
  static const columnNotifNombreRecibioNotificacion = 'notif_nombre_recibio';
  static const columnNotifDijoSerNotificacion = 'notif_dijo_ser';
  static const columnNotifObservacionesNotificacion = 'notif_observaciones';
  static const columnSysUsrInsertNotificacion = 'sys_usr_insert';
  static const columnSysFecInserNotificacion = 'sys_fec_insert';
  static const columnSysUsrUpdateNotificacion = 'sys_usr_update';
  static const columnSysFecUpdateNotificacion = 'sys_fec_update';

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
        version: _databaseVersion, onCreate: _onCreate, onOpen: (db) async {
      // Verifica si la tabla credenciales existe
      var credencialesTableExists = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableCredenciales'");
      // Si no existe, crea la tabla credenciales
      if (credencialesTableExists.isEmpty) {
        await _onCreateCredenciales(db, _databaseVersion);
      }

      // Verifica si la tabla personas existe
      var personasTableExists = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tablePersonas'");
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

      // Verifica si la tabla notificacion existe
      var notificacionTableExists = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableNotificacion'");
      // Si no existe, crea la tabla notificacion
      if (notificacionTableExists.isEmpty) {
        await _onCreateNotificacion(db, _databaseVersion);
      }
    });
  }

  // Crea la tabla personas y la tabla paises
  Future _onCreate(Database db, int version) async {
    // Crea la tabla credenciales
    await _onCreateCredenciales(db, version);
    // Crea la tabla personas
    await _onCreatePersonas(db, version);
    // Crea la tabla paises
    await _onCreatePaises(db, version);

    await _onCreateNotificacion(db, version);
  }

  // Crea la tabla personas
  Future _onCreateCredenciales(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableCredenciales (
      $columnCredencialId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnCredencialUserCoreId INTEGER NOT NULL,
      $columnCredencialActivo INTEGER NOT NULL,
      $columnCredencialNombre TEXT NOT NULL,
      $columnCredencialPrimerApellido TEXT NOT NULL,
      $columnCredencialSegundoApellido TEXT NOT NULL,
      $columnCredencialUsuario TEXT NOT NULL,
      $columnCredencialPassword TEXT NOT NULL,
      $columnCredencialToken TEXT NOT NULL
    )
  ''');
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

  // Crea la tabla personas
  Future _onCreatePersonas(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tablePersonas (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnNombre TEXT NOT NULL,
      $columnPrimerApellido TEXT NOT NULL,
      $columnSegundoApellido TEXT NOT NULL,
      $columnEdad INTEGER NOT NULL,
      $columnGenero TEXT NOT NULL
    )
  ''');
  }

  // Crea la tabla notificacion
  Future _onCreateNotificacion(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableNotificacion (
      $columnNotificacionId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTipoDocumentoIdNotificacion INTEGER,
      $columnInspectorIdNotificacion INTEGER,
      $columnInspeccionIdNotificacion INTEGER,
      $columnNotifMotivoNoEntregaIdNotificacion INTEGER,
      $columnNotifFormaConstatacionIdNotificacion INTEGER,
      $columnNotifEstatusAsignacionNotificacion INTEGER,
      $columnNotifFormaEntregaNotificacion INTEGER,
      $columnNotifFormaEnvioNotificacion TEXT,
      $columnNotifFecLimiteEntregaNotificacion TEXT,
      $columnNotifHoraLimiteRecepcionNotificacion TEXT,
      $columnNotifNotificacionPersonalNotificacion INTEGER,
      $columnNotifFecEnvioNotificacion TEXT,
      $columnNotifNumGuiaNotificacion TEXT,
      $columnNotifFecEntregaProgramadaNotificacion TEXT,
      $columnNotifEstatusEntregaNotificacion INTEGER,
      $columnNotifSeRecibioNotificacion INTEGER,
      $columnNotifQuedoPegadoNotificacion INTEGER,
      $columnNotifOtroMotivoNotificacion TEXT,
      $columnNotifFecEntregaNotificacion TEXT,
      $columnNotifNombreRecibioNotificacion TEXT,
      $columnNotifDijoSerNotificacion TEXT,
      $columnNotifObservacionesNotificacion TEXT,
      $columnSysUsrInsertNotificacion TEXT,
      $columnSysFecInserNotificacion TEXT,
      $columnSysUsrUpdateNotificacion TEXT,
      $columnSysFecUpdateNotificacion TEXT
    )
  ''');
  }

  /// ************************************************************
  ///                       CREDENCIALES
  /// ************************************************************
  // Inserta un registro en la tabla credenciales
  Future<int?> insertCredencial(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tableCredenciales, row);
  }

  //Inserta un elemento a la tabla
  Future<Credencial> createCredencial(Credencial credencial) async {
    Database? db = await instance.database;
    credencial.id = await db!.insert(
      tableCredenciales,
      credencial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return credencial;
  }

  //Recupera un elemento de la lista por el id
  Future<List<Map<String, dynamic>>> getCredencial(int id) async {
    Database? db = await instance.database;
    return db!
        .query(tableCredenciales, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  //Recupera un elemento de la lista por el usuario
  Future<List<Map<String, dynamic>>> getCredencialByUsuario(
      String usuario) async {
    Database? db = await instance.database;
    return db!.query(tableCredenciales,
        where: 'usuario = ?', whereArgs: [usuario], limit: 1);
  }

  //Recupera un elemento de la lista por el userCoreId
  Future<List<Map<String, dynamic>>> getCredencialByUserCoreId(
      int userCoreId) async {
    Database? db = await instance.database;
    return db!.query(tableCredenciales,
        where: 'user_core_id = ?', whereArgs: [userCoreId], limit: 1);
  }

  //Recupera la lista de elementos de la tabla
  Future<List<Map<String, dynamic>>> getCredenciales() async {
    Database? db = await instance.database;
    return await db!.query(tableCredenciales);
  }

  //Borra un elemento de la tabla por el id
  Future<int> deleteCredencial(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableCredenciales, where: 'id = ?', whereArgs: [id]);
  }

  //Actualiza un elemento
  Future<int> updateCredencial(Credencial credencial) async {
    Database? db = await instance.database;
    return await db!.update(tableCredenciales, credencial.toMap(),
        where: 'id = ?', whereArgs: [credencial.id]);
  }

  //Cambia el atributo activo por el valor indicado a todos los elementos
  void setCredencialesActivo(int activo) async {
    Database? db = await instance.database;
    db!.execute("UPDATE $tableCredenciales SET activo=$activo");
  }

  //Cambia el atributo activo por el valor indicado a un elemento
  void setCredencialActivo(int? id, int activo) async {
    Database? db = await instance.database;
    if (id != null)
      db!.execute("UPDATE $tableCredenciales SET activo=$activo WHERE id=$id");
  }

  /// ************************************************************
  ///                           PERSONAS
  /// ************************************************************
  // Inserta un registro en la tabla personas
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tablePersonas, row);
  }

  // Inserta un registro en la tabla notificacion
  Future<int?> insertNotificacion(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tableNotificacion, row);
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
      batch.insert(tablePaises, row,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit();
  }

  //Obtiene el listado de paises de la tabla paises
  Future<List<Map<String, dynamic>>> queryAllPaises() async {
    Database? db = await instance.database;
    return await db!.query(tablePaises);
  }

  //Obtiene el listado de notificaciones de la tabla notificacion
  Future<List<Map<String, dynamic>>> queryAllNotificaciones() async {
    Database? db = await instance.database;
    return await db!.query(tableNotificacion);
  }
}
