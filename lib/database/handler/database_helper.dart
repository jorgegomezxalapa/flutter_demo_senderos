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
  //tabla notificaciones
  static const tableNotificacion = 'notificacion';
  static const columnNotificacionId = 'notificacion_id';
  static const columnTipoDocumentoIdNotificacion = 'tipo_documento_id';
  static const columnInspectorIdNotificacion = 'inspector_id';
  static const columnInspeccionIdNotificacion = 'inspeccion_id';
  static const columnNotifMotivoNoEntregaIdNotificacion = 'notif_motivo_no_entrega_id';
  static const columnNotifFormaConstatacionIdNotificacion = 'notif_forma_constatacion_id';
  static const columnNotifEstatusAsignacionNotificacion = 'notif_estatus_asignacion';
  static const columnNotifFormaEntregaNotificacion = 'notif_forma_entrega';
  static const columnNotifFormaEnvioNotificacion = 'notif_forma_envio';
  static const columnNotifFecLimiteEntregaNotificacion = 'notif_fec_limite_entrega';
  static const columnNotifHoraLimiteRecepcionNotificacion = 'notif_hora_limite_recepcion';
  static const columnNotifNotificacionPersonalNotificacion = 'notif_notificacion_personal';
  static const columnNotifFecEnvioNotificacion = 'notif_fec_envio';
  static const columnNotifNumGuiaNotificacion = 'notif_num_guia';
  static const columnNotifFecEntregaProgramadaNotificacion = 'notif_fec_entrega_programada';
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

  //tabla inspeccion
  static const tableInspeccion = 'inspeccion';
  static const columnInspeccionIdInspeccion = 'inspeccion_id';
  static const columnInspectorIdInspeccion = 'inspector_id';
  static const columnNotificadorIdInspeccion = 'notificador_id';
  static const columnMesIdInspeccion = 'mes_id';
  static const columnMateriaIdInspeccion = 'materia_id';
  static const columnFundamentoDesignacionIdInspeccion = 'fundamento_designacion_id';
  static const columnMotivoInspeccionIdInspeccion = 'motivo_inspeccion_id';
  static const columnSubtipoInspeccionIdInspeccion = 'subtipo_inspeccion_id';
  static const columnOperativoIdInspeccion = 'operativo_id';
  static const columnCveUrInspeccion = 'cve_ur';
  static const columnCveRamaInspeccion = 'cve_rama';
  static const columnCentroTrabajoIdInspeccion = 'centro_trabajo_id';
  static const columnInAnioInspeccion = 'in_anio';
  static const columnInNumExpedienteInspeccion = 'in_num_expediente';
  static const columnInOtraSubmateriaInspeccion = 'in_otra_submateria';
  static const columnInCtRfcInspeccion = 'in_ct_rfc';
  static const columnInCtRazonSocialInspeccion = 'in_ct_razon_social';
  static const columnInCtNombreInspeccion = 'in_ct_nombre';
  static const columnInCtImssRegistroInspeccion = 'in_ct_imss_registro';
  static const columnInCtClaseRegistroInspeccion = 'in_ct_clase_registro';
  static const columnInFecInspeccionInspeccion = 'in_fec_inspeccion';
  static const columnInAlcanceInspeccion = 'in_alcance';
  static const columnInHabilitarDiasInhabilesInspeccion = 'in_habilitar_dias_inhabiles';
  static const columnInHabilitarHorasInhabilesInspeccion = 'in_habilitar_horas_inhabiles';
  static const columnInIncluyeNomsEspInspeccion = 'in_incluye_noms_esp';
  static const columnInFecEmisionInspeccion = 'in_fec_emision';
  static const columnInEsInspeccionEnCentroInspeccion = 'in_es_inspeccion_en_centro';
  static const columnInDomicilioInspeccionInspeccion = 'in_domicilio_inspeccion';
  static const columnInFirmanTitularesInspeccion = 'in_firman_titulares';
  static const columnInNombreFirmanteInspeccion = 'in_nombre_firmante';
  static const columnInCargoFirmanteInspeccion = 'in_cargo_firmante';
  static const columnInGenerarCitatorioInspeccion = 'in_generar_citatorio';
  static const columnInIncluirNotificadorInspeccion = 'in_incluir_notificador';
  static const columnInEnDeclareInspeccion = 'in_en_declare';
  static const columnInEnPasstInspeccion = 'in_en_passt';
  static const columnInMedioInformacionInspeccion = 'in_medio_informacion';
  static const columnInReqDocumentosInicioInspeccion = 'in_req_documentos_inicio';
  static const columnInReqDocumentosTermino = 'in_req_documentos_termino';
  static const columnInRspTipoEquipoInspeccion = 'in_rsp_tipo_equipo';
  static const columnInRspEquipoInspeccion = 'in_rsp_equipo';
  static const columnInRspNumControl = 'in_rsp_num_control';
  static const columnInRspFecAutorizacionProvisionalInspeccion = 'in_rsp_fec_autorizacion_provisional';
  static const columnInRspTipoAvisoInspeccion = 'in_rsp_tipo_aviso';
  static const columnInRspFolioInspeccion = 'in_rsp_folio';
  static const columnInRspPruebasInspeccion = 'in_rsp_pruebas';
  static const columnInResultadoInspeccion = 'in_resultado';
  static const columnInEtapaInspeccion = 'in_etapa';
  static const columnInEstatusInspeccion = 'in_estatus';
  static const columnSysUsrInsertInspeccion = 'sys_usr_insert';
  static const columnSysFecInsertInspeccion = 'sys_fec_insert';
  static const columnSysUsrUpdateInspeccion = 'sys_usr_update';
  static const columnSysFecUpdateInspeccion = 'sys_fec_update';
  static const columnInDomicilioInspeccion2Inspeccion = 'in_domicilio_inspeccion2';
  static const columnInTipoProgramacionIdInspeccion = 'in_tipo_programacion_id';
  static const columnInOtraMateriaMotivoInspeccion = 'in_otra_materia_motivo';
  static const columnInOtraMateriaSubmateriaInspeccion = 'in_otra_materia_submateria';
  static const columnInAplicaEspeciaInspeccion = 'in_aplica_especial';
  static const columnMateriaGrupoIdInspeccion = 'materia_grupo_id';
  static const columnInHrInspeccionInspeccion = 'in_hr_inspeccion';
  static const columnInspeccionOrigenIdInspeccion = 'inspeccion_origen_id';
  static const columnCveUrComisionInspeccion = 'cve_ur_comision';
  static const columnNormativaVersionIdInspeccion = 'normativa_version_id';
  static const columnInIdFirmanteInspeccion = 'in_id_firmante';


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

          // Verifica si la tabla notificacion existe
          var notificacionTableExists = await db.rawQuery(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableNotificacion'");
          // Si no existe, crea la tabla notificacion
          if (notificacionTableExists.isEmpty) {
            await _onCreateNotificacion(db, _databaseVersion);
          }

          // Verifica si la tabla inspeccion existe
          var inspeccionTableExists = await db.rawQuery(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableInspeccion'");
          // Si no existe, crea la tabla notificacion
          if (inspeccionTableExists.isEmpty) {
            await _onCreateInspeccion(db, _databaseVersion);
          }
        });
  }

  // Crea las tablas
  Future _onCreate(Database db, int version) async {
    // Crea la tabla personas
    await _onCreatePersonas(db, version);
    // Crea la tabla paises
    await _onCreatePaises(db, version);
    //crea la tabla notificacion
    await _onCreateNotificacion(db, version);
    //crea la tabla inspeccion
    await _onCreateInspeccion(db, version);
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

  // Crea la tabla inspeccion
  Future _onCreateInspeccion(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableInspeccion (
      $columnInspeccionIdInspeccion INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnInspectorIdInspeccion INTEGER,
      $columnNotificadorIdInspeccion INTEGER,
      $columnMesIdInspeccion INTEGER,
      $columnMateriaIdInspeccion INTEGER,
      $columnFundamentoDesignacionIdInspeccion INTEGER,
      $columnMotivoInspeccionIdInspeccion INTEGER,
      $columnSubtipoInspeccionIdInspeccion INTEGER,
      $columnOperativoIdInspeccion INTEGER,
      $columnCveUrInspeccion INTEGER,
      $columnCveRamaInspeccion INTEGER,
      $columnCentroTrabajoIdInspeccion INTEGER,
      $columnInAnioInspeccion INTEGER,
      $columnInNumExpedienteInspeccion TEXT,
      $columnInOtraSubmateriaInspeccion TEXT,
      $columnInCtRfcInspeccion TEXT,
      $columnInCtRazonSocialInspeccion TEXT,
      $columnInCtNombreInspeccion TEXT,
      $columnInCtImssRegistroInspeccion TEXT,
      $columnInCtClaseRegistroInspeccion TEXT,
      $columnInFecInspeccionInspeccion TEXT,
      $columnInAlcanceInspeccion INTEGER,
      $columnInHabilitarDiasInhabilesInspeccion INTEGER,
      $columnInHabilitarHorasInhabilesInspeccion INTEGER,
      $columnInIncluyeNomsEspInspeccion INTEGER,
      $columnInFecEmisionInspeccion TEXT,
      $columnInEsInspeccionEnCentroInspeccion INTEGER,
      $columnInDomicilioInspeccionInspeccion TEXT,
      $columnInFirmanTitularesInspeccion INTEGER,
      $columnInNombreFirmanteInspeccion TEXT,
      $columnInCargoFirmanteInspeccion TEXT,
      $columnInGenerarCitatorioInspeccion INTEGER,
      $columnInIncluirNotificadorInspeccion INTEGER,
      $columnInEnDeclareInspeccion INTEGER,
      $columnInEnPasstInspeccion INTEGER,
      $columnInMedioInformacionInspeccion TEXT,
      $columnInReqDocumentosInicioInspeccion TEXT,
      $columnInReqDocumentosTermino TEXT,
      $columnInRspTipoEquipoInspeccion TEXT,
      $columnInRspEquipoInspeccion TEXT,
      $columnInRspNumControl TEXT,
      $columnInRspFecAutorizacionProvisionalInspeccion TEXT,
      $columnInRspTipoAvisoInspeccion TEXT,
      $columnInRspFolioInspeccion TEXT,
      $columnInRspPruebasInspeccion TEXT,
      $columnInResultadoInspeccion INTEGER,
      $columnInEtapaInspeccion INTEGER,
      $columnInEstatusInspeccion INTEGER,
      $columnSysUsrInsertInspeccion TEXT,
      $columnSysFecInsertInspeccion TEXT,
      $columnSysUsrUpdateInspeccion TEXT,
      $columnSysFecUpdateInspeccion TEXT,
      $columnInDomicilioInspeccion2Inspeccion TEXT,
      $columnInTipoProgramacionIdInspeccion INTEGER,
      $columnInOtraMateriaMotivoInspeccion TEXT,
      $columnInOtraMateriaSubmateriaInspeccion INTEGER,
      $columnInAplicaEspeciaInspeccion INTEGER,
      $columnMateriaGrupoIdInspeccion INTEGER,
      $columnInHrInspeccionInspeccion TEXT,
      $columnInspeccionOrigenIdInspeccion INTEGER,
      $columnCveUrComisionInspeccion INTEGER,
      $columnNormativaVersionIdInspeccion INTEGER,
      $columnInIdFirmanteInspeccion INTEGER
    )
  ''');

    // Crea una lista de inspecciones fake
    List<Map<String, dynamic>> inspecciones = [
      {
        DatabaseHelper.columnNormativaVersionIdInspeccion : 1,
        DatabaseHelper.columnInCtRazonSocialInspeccion: 'DULCERA MEXICANA',
        DatabaseHelper.columnInDomicilioInspeccionInspeccion: 'BAHíA DE SANTA BáRBARA ESQ. CIRCUITO INTERIOR, ALVARO OBREGON, DISTRITO FEDERAL.',
        DatabaseHelper.columnInFecInspeccionInspeccion : '2023-05-18 12:00:00',
        DatabaseHelper.columnInNumExpedienteInspeccion : '221/000108/2023',
        DatabaseHelper.columnSubtipoInspeccionIdInspeccion : 1,
        DatabaseHelper.columnMateriaIdInspeccion : 1,
        DatabaseHelper.columnInAlcanceInspeccion : 1,
        DatabaseHelper.columnInGenerarCitatorioInspeccion : 1,
      },
      {
        DatabaseHelper.columnNormativaVersionIdInspeccion : 2,
        DatabaseHelper.columnInCtRazonSocialInspeccion: 'AGENCIA AUTOCAMIONES LA JOYA',
        DatabaseHelper.columnInDomicilioInspeccionInspeccion: 'CARRTERA INSTERNACIONAL No. 821 COL. EUCALIPTOS, ABEJONES, OAXACA.',
        DatabaseHelper.columnInFecInspeccionInspeccion : '2023-01-28 19:00:00',
        DatabaseHelper.columnInNumExpedienteInspeccion : '021/000008/2023',
        DatabaseHelper.columnSubtipoInspeccionIdInspeccion : 2,
        DatabaseHelper.columnMateriaIdInspeccion : 2,
        DatabaseHelper.columnInAlcanceInspeccion : 2,
        DatabaseHelper.columnInGenerarCitatorioInspeccion : 2,
      },
      {
        DatabaseHelper.columnNormativaVersionIdInspeccion : 3,
        DatabaseHelper.columnInCtRazonSocialInspeccion: 'AUTOS MEXICANOS S.A. DE C.V.',
        DatabaseHelper.columnInDomicilioInspeccionInspeccion: 'AVENIDA UNIVERSIDAD No. 733 COL. EXHACIENDA, ABEJONES, OAXACA.',
        DatabaseHelper.columnInFecInspeccionInspeccion : '2023-04-20 10:30:00',
        DatabaseHelper.columnInNumExpedienteInspeccion : '221/000044/2023',
        DatabaseHelper.columnSubtipoInspeccionIdInspeccion : 3,
        DatabaseHelper.columnMateriaIdInspeccion : 3,
        DatabaseHelper.columnInAlcanceInspeccion :3,
        DatabaseHelper.columnInGenerarCitatorioInspeccion : 1,
      },
      {
        DatabaseHelper.columnNormativaVersionIdInspeccion : 4,
        DatabaseHelper.columnInCtRazonSocialInspeccion: 'BIMBO, S.A. DE C.V.',
        DatabaseHelper.columnInDomicilioInspeccionInspeccion: 'CERRO AZUL No. 231, Interior N/A, Colonia JARDINES DE SAN JOAQUIN, C.P. 59617, ZAMORA, MICHOACAN.',
        DatabaseHelper.columnInFecInspeccionInspeccion : '2023-05-01 16:30:00',
        DatabaseHelper.columnInNumExpedienteInspeccion : '221/000074/2023',
        DatabaseHelper.columnSubtipoInspeccionIdInspeccion : 4,
        DatabaseHelper.columnMateriaIdInspeccion : 4,
        DatabaseHelper.columnInAlcanceInspeccion : 4,
        DatabaseHelper.columnInGenerarCitatorioInspeccion : 2,
      },
      {
        DatabaseHelper.columnNormativaVersionIdInspeccion : 5,
        DatabaseHelper.columnInCtRazonSocialInspeccion: 'LOGISTICA INTEGRAL DE LIMPIEZA DE LEON, S.A. DE C.V.',
        DatabaseHelper.columnInDomicilioInspeccionInspeccion: 'MANUEL PRIEGO No. 3, Colonia RANCHO GRANDE, C.P. 36543, IRAPUATO, GUANAJUATO',
        DatabaseHelper.columnInFecInspeccionInspeccion : '2023-05-18 11:00:00',
        DatabaseHelper.columnInNumExpedienteInspeccion : '221/000072/2023',
        DatabaseHelper.columnSubtipoInspeccionIdInspeccion : 5,
        DatabaseHelper.columnMateriaIdInspeccion : 5,
        DatabaseHelper.columnInAlcanceInspeccion : 5,
        DatabaseHelper.columnInGenerarCitatorioInspeccion : 1,
      }
    ];

    for (var inspeccion in inspecciones) {
      await db.insert(tableInspeccion, inspeccion);
    }

  }

  // Inserta un registro en la tabla personas
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
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
      batch.insert(tablePaises, row, conflictAlgorithm: ConflictAlgorithm.ignore);
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

  //Obtiene el listado de inspecciones de la tabla inspeccion
  Future<List<Map<String, dynamic>>> queryAllInspecciones() async {
    Database? db = await instance.database;
    return await db!.query(tableInspeccion);
  }

  Future<List<Map<String, dynamic>>> queryInspeccion(int id) async {
    Database? db = await instance.database;
    return await db!.query(
      tableInspeccion,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}