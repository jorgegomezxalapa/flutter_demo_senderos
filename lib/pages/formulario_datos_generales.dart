import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:air_senderos/widgets/cargar_documento_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:air_senderos/pages/widgets/selects/selects_formulario_datos_generales.dart';

class FormularioDatosGenerales extends StatefulWidget {
  final int? inspeccionId;
  String? titulo = 'Formulario Datos Generales';
  FormularioDatosGenerales({super.key, @required this.inspeccionId});

  @override
  FormularioDatosGeneralesState createState() =>
      FormularioDatosGeneralesState();
}

class FormularioDatosGeneralesState extends State<FormularioDatosGenerales> {

  late List<Map<String, dynamic>> _inspeccion = [];
  late List<Map<String, dynamic>> _inspeccionNotificacion = [];
  int? notificacionId;

  @override
  void initState() {
    super.initState();
    _getInspeccion();
    _getInspeccionNotificacion();
  }

  //variables de consulta
  String? normatividad;
  int? normatividadId;
  String? nombreRazonSocial;
  String? domicilio;
  String? fechaInspeccion;
  String? expediente;
  String? tipoActuacion ; // no se encuentra en la db
  int? subtipo_actuacion_id;
  String? subtipo_actuacion;
  int? materia_id;
  String? tipoMateria;
  int? alcance_id;
  String? alcance;
  String? expidioCitatorio;
  int? expidioCitatorio_id;
  String? fechaHoraEntregaSting;

  //variables del formulario
  final _formularioDatosGenerales = GlobalKey<FormState>();
  var _nombreRecibioController = TextEditingController();
  var _dijoSerController = TextEditingController();
  int? _radioRecibioEmpresa;
  int? _radioSeDejoPegado;
  int? _selectedOptionMotivo;
  int? _selectedOptionFormaConstatacion;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? radioDocumentoPorGenerar;

  //Obtiene el registro de la inspeccion
  Future<void> _getInspeccion() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;
    // Consulta el registro de la tabla inspecciones
    List<Map<String, Object?>>? inspeccion = await db?.query(
      DatabaseHelper.tableInspeccion,
      where: 'inspeccion_id = ?',
      whereArgs: [widget.inspeccionId],
    );
    _inspeccion = inspeccion ?? [];
    // Actualiza el estado del widget con los registros obtenidos
    _asignarVariablesDomInspeccion();
    setState(() {});
  }

  //obtiene el registro de la notificacion si es que existe
  Future<void> _getInspeccionNotificacion() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;
    // Consulta el registro de la tabla inspecciones
    List<Map<String, Object?>>? inspeccionNotificacion = await db?.query(
      DatabaseHelper.tableNotificacion,
      where: 'inspeccion_id = ?',
      whereArgs: [widget.inspeccionId],
    );
    _inspeccionNotificacion = inspeccionNotificacion ?? [];
   if(_inspeccionNotificacion.isNotEmpty){
     notificacionId = _inspeccionNotificacion.first[DatabaseHelper.columnNotificacionId];
     _asignarVariablesDomNotificacion();
   }
    // Actualiza el estado del widget con los registros obtenidos
    setState(() {});
  }

  //Actualiza el DOM de la inspeccion
  void _asignarVariablesDomInspeccion() {
    if(_inspeccion.isNotEmpty){
      normatividadId =
      _inspeccion.first[DatabaseHelper.columnNormativaVersionIdInspeccion];
      switch (normatividadId) {
        case 1:
          normatividad = 'SIAPI 2021';
          break;
        case 2:
          normatividad = 'NORMATIVIDAD PRUEBAS QA';
          break;
        case 3:
          normatividad = 'NORMATIVIDAD NL';
          break;
        case 4:
          normatividad = 'NORMATIVIDAD PRUEBA';
          break;
        case 5:
          normatividad = 'NORMATIVIDAD SIAPI SIPAS';
          break;
        default:
          normatividad = '';
      }
      nombreRazonSocial =
      _inspeccion.first[DatabaseHelper.columnInCtRazonSocialInspeccion];
      domicilio = _inspeccion
          .first[DatabaseHelper.columnInDomicilioInspeccionInspeccion];
      fechaInspeccion =
      _inspeccion.first[DatabaseHelper.columnInFecInspeccionInspeccion];
      expediente =
      _inspeccion.first[DatabaseHelper.columnInNumExpedienteInspeccion];
      tipoActuacion = 'Extraordinaria'; // no se encuentra en la db
      subtipo_actuacion_id =
      _inspeccion.first[DatabaseHelper.columnSubtipoInspeccionIdInspeccion];
      switch (subtipo_actuacion_id) {
        case 1:
          subtipo_actuacion = 'Inicial';
          break;
        case 2:
          subtipo_actuacion = 'Periodica';
          break;
        case 3:
          subtipo_actuacion = 'Extraordinaria';
          break;
        case 4:
          subtipo_actuacion = 'Comprobacion de medidas';
          break;
        case 5:
          subtipo_actuacion = 'Extraordinaria de orientacion y asesoria';
          break;
        default:
          subtipo_actuacion = '';
      }

      materia_id = _inspeccion.first[DatabaseHelper.columnMateriaIdInspeccion];
      switch (materia_id) {
        case 1:
          tipoMateria = 'Seguridad e Higiene';
          break;
        case 2:
          tipoMateria = 'Condiciones generales de trabajo';
          break;
        case 3:
          tipoMateria = 'Capacitación y adiestramiento ';
          break;
        case 4:
          tipoMateria = 'Constatación y actualización de datos';
          break;
        case 5:
          tipoMateria = 'Otra';
          break;
        default:
          tipoMateria = '';
      }
      alcance_id = _inspeccion.first[DatabaseHelper.columnInAlcanceInspeccion];
      switch (alcance_id) {
        case 1:
          alcance = 'Específico';
          break;
        case 2:
          alcance = 'No Específico';
          break;
        case 3:
          alcance = 'Específico';
          break;
        case 4:
          alcance = 'No Específico';
          break;
        case 5:
          alcance = 'Específico';
          break;
        default:
          tipoMateria = '';
      }
      expidioCitatorio_id =
      _inspeccion.first[DatabaseHelper.columnInGenerarCitatorioInspeccion];
      expidioCitatorio_id = (expidioCitatorio_id == 1) ? 1 : 0;
      expidioCitatorio = (expidioCitatorio_id == 1) ? 'Sí' : 'No';
    }
  }

  //actualiza el DOM de la notificacion
  void _asignarVariablesDomNotificacion() {
    String? dijoSer;
    String? nombrePersonaRecibio;

    if (_inspeccionNotificacion.isNotEmpty) {

      dijoSer = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifDijoSerNotificacion];

      nombrePersonaRecibio = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifNombreRecibioNotificacion];

      _radioRecibioEmpresa = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifSeRecibioNotificacion];

      _radioSeDejoPegado = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifQuedoPegadoNotificacion];
      _selectedOptionMotivo = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifMotivoNoEntregaIdNotificacion];

      _selectedOptionFormaConstatacion = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifFormaConstatacionIdNotificacion];
      radioDocumentoPorGenerar = _inspeccionNotificacion
          .first[DatabaseHelper.columnTipoDocumentoIdNotificacion];
      fechaHoraEntregaSting = _inspeccionNotificacion
          .first[DatabaseHelper.columnNotifFecEntregaNotificacion];
      if(_inspeccionNotificacion
          .first[DatabaseHelper.columnNotifFecEntregaNotificacion] != null){
        final String dateTimeString = _inspeccionNotificacion
            .first[DatabaseHelper.columnNotifFecEntregaNotificacion]; // This is the date and time string from your database
        final DateTime dateTime = DateTime.parse(dateTimeString);
        _selectedDate = dateTime;
        _selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
        final String formattedDate = DateFormat('d MMMM yyyy', 'es').format(dateTime);
        final String formattedTime = DateFormat('h:mm a', 'es').format(dateTime);
        fechaHoraEntregaSting = '$formattedDate Hora: $formattedTime';
      }
    }
    _dijoSerController = TextEditingController(text: dijoSer);
    _nombreRecibioController = TextEditingController(text: nombrePersonaRecibio);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    _actualizarDomFechaSeleccionada();
    setState(() {});
  }

  void _actualizarDomFechaSeleccionada(){
    if (_selectedDate != null && _selectedTime != null) {
      final DateTime dateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      final String formattedDate = DateFormat('d MMMM yyyy', 'es').format(dateTime);
      final String formattedTime = DateFormat('h:mm a', 'es').format(dateTime);
      fechaHoraEntregaSting = '$formattedDate Hora: $formattedTime';
    }
  }


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay initialTime = _selectedTime ?? TimeOfDay.now();
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: initialTime);
    if (picked != null && picked != _selectedTime) {
      _selectedTime = picked;
    }
    _actualizarDomFechaSeleccionada();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _inspeccion.isEmpty
          ?
      const CircularProgressIndicator()
          :
      SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: SafeArea(
                child: Form(
                  key: _formularioDatosGenerales,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Datos de la inspección',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.teal[800],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 2, 0),
                                  child: Text(
                                    'Normatividad:',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  child: Text(
                                    normatividad??'',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.334,
                                child: Row(
                                  children: [
                                    Text(
                                      'Datos del centro de trabajo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre o razón social',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(nombreRazonSocial??''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Domicilio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(domicilio??''),
                                    ],
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.334,
                                child: Row(
                                  children: [
                                    Text(
                                      'Datos de la actuación',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fecha de inspección',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(fechaInspeccion??''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No. de expediente',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(expediente??''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tipo de actuación',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(tipoActuacion??''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subtipo de actuación',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(subtipo_actuacion ?? ''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tipo materia',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(tipoMateria??''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alcance',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(alcance??''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.334,
                                child: Row(
                                  children: [
                                    Text(
                                      'Datos de la notificación del citatorio',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Se expidió citatorio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(expidioCitatorio??''),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: expidioCitatorio_id == 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Recibió la empresa*',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: _radioRecibioEmpresa,
                                              onChanged: (value) {
                                                setState(() {
                                                  _radioRecibioEmpresa = value!;
                                                });
                                              },
                                            ),
                                            const Text('Sí'),
                                            Radio(
                                              value: 0,
                                              groupValue: _radioRecibioEmpresa,
                                              onChanged: (value) {
                                                setState(() {
                                                  _radioRecibioEmpresa = value!;
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: _radioRecibioEmpresa == 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Se dejó pegado *',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: _radioSeDejoPegado,
                                              onChanged: (value) {
                                                setState(() {
                                                  _radioSeDejoPegado = value!;
                                                });
                                              },
                                            ),
                                            const Text('Sí'),
                                            Radio(
                                              value: 0,
                                              groupValue: _radioSeDejoPegado,
                                              onChanged: (value) {
                                                setState(() {
                                                  _radioSeDejoPegado = value!;
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _radioRecibioEmpresa == 0,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Motivo*',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Container(
                                          child: FormField<int?>(
                                            initialValue: _selectedOptionMotivo,
                                            builder:
                                                (FormFieldState<int?> state) {
                                              return DropdownButton<int?>(
                                                value: state.value,
                                                onChanged: (int? newValue) {
                                                  setState(() {
                                                    _selectedOptionMotivo =
                                                        newValue!;
                                                  });
                                                  state.didChange(newValue);
                                                },
                                                items: motivosOpciones
                                                    .map<DropdownMenuItem<int>>(
                                                        (SelectorMotivo opcion) {
                                                  return DropdownMenuItem<int>(
                                                    value: opcion.id,
                                                    child: Text(opcion.texto),
                                                  );
                                                }).toList(),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  const Expanded(flex: 1, child: SizedBox()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: expidioCitatorio_id == 1,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Forma de constatación de razón social y domicilio',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            fontSize: 12,
                                          ),
                                        ),
                                        FormField<int?>(
                                          initialValue: _selectedOptionFormaConstatacion,
                                          builder:
                                              (FormFieldState<int?> state) {
                                            return DropdownButton<int?>(
                                              value: state.value,
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  _selectedOptionFormaConstatacion =
                                                  newValue!;
                                                });
                                                state.didChange(newValue);
                                              },
                                              items: formasOpciones
                                                  .map<DropdownMenuItem<int>>(
                                                      (SelectorFormaConstatacion forma) {
                                                    return DropdownMenuItem<int>(
                                                      value: forma.id,
                                                      child: Text(forma.texto),
                                                    );
                                                  }).toList(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: _radioRecibioEmpresa == 1,
                                    child: Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nombre de la persona que recibió',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[700],
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 20),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                key: const Key(
                                                    '_nombreRecibioController'),
                                                controller:
                                                    _nombreRecibioController,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Por favor ingrese un valor';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _radioRecibioEmpresa == 1,
                                    child: Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dijo ser(puesto)*',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[700],
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 20),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                key: const Key(
                                                    '_dijoSerController'),
                                                controller: _dijoSerController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Por favor ingrese un valor';
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _radioRecibioEmpresa == 0,
                                    child: Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              'Fecha y hora de entregass*',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _selectedDate != null && _selectedTime != null
                                                  ?
                                              Text(fechaHoraEntregaSting??'')
                                                  :
                                              const Text('Seleccionar fecha y hora')
                                             ,
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 8, right: 10),
                                                    child: ElevatedButton(
                                                      onPressed: () =>
                                                          _selectDate(context),
                                                      child: const Text('Fecha'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 8),
                                                    child: ElevatedButton(
                                                      onPressed: () =>
                                                          _selectTime(context),
                                                      child: const Text('Hora'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _radioRecibioEmpresa == 0,
                                    child: const Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: (expidioCitatorio_id == 1 && _radioRecibioEmpresa == 1),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fecha y hora de entrega*',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        _selectedDate != null && _selectedTime != null
                                            ?
                                        Text(fechaHoraEntregaSting??'')
                                            :
                                        const Text('Seleccionar fecha y hora'),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    _selectDate(context),
                                                child: const Text('Fecha'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    _selectTime(context),
                                                child: const Text('Hora'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.334,
                                child: Row(
                                  children: [
                                    Text(
                                      'Cargar documentos firmados',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(
                                    titleText: 'Orden de inspección',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(
                                    titleText: 'Citatorio',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(
                                    titleText: 'Listado anexo de documentos',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(
                                    titleText:
                                        'Guía de derechos y obligaciones',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(
                                    titleText: 'Doc_ARCR_Programación',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.334,
                                child: Row(
                                  children: [
                                    Text(
                                      'Documento por generar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const IntrinsicHeight(
                            child: Row(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      ListTileTheme(
                        dense: true,
                        contentPadding: const EdgeInsets.only(left: 0.0),
                        child: Column(
                          children: <Widget>[
                            RadioListTile(
                              title: const Text("Informe de comisión"),
                              value: 1,
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Acta de inspección"),
                              value: 2,
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Negativa patronal"),
                              value: 3,
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final snackBar = SnackBar(
                                content: const Text('Formulario guardado'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {},
                                ),
                              );


                              //Variablas finales del formulario
                              final inspeccionId = widget.inspeccionId;
                              final recibioEmpresa = (expidioCitatorio_id == 1) ? _radioRecibioEmpresa : null;
                              final quedoPegado =( _radioRecibioEmpresa == 1 || _radioRecibioEmpresa == null) ? null : _radioSeDejoPegado;
                              final motivo = ( _radioRecibioEmpresa == 1 || _radioRecibioEmpresa == null) ? null : _selectedOptionMotivo;
                              final formaConstatacion = _selectedOptionFormaConstatacion;
                              var fechaEntrega = null;
                              if (expidioCitatorio_id == 1 && _selectedDate != null && _selectedTime != null) {
                                final DateTime dateTime = DateTime(
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                  _selectedDate!.day,
                                  _selectedTime!.hour,
                                  _selectedTime!.minute,
                                );
                                fechaEntrega = dateTime.toIso8601String();
                              }
                              final nombre_recibio = (_radioRecibioEmpresa == 0) ? null : _nombreRecibioController.text;
                              final dijoSer = (_radioRecibioEmpresa == 0) ? null : _dijoSerController.text;
                              final tipoDocumento = radioDocumentoPorGenerar;

                              //objeto para base de datos
                              var notificacionRow = {
                                DatabaseHelper.columnInspeccionIdNotificacion: inspeccionId,
                                DatabaseHelper.columnNotifSeRecibioNotificacion: recibioEmpresa,
                                DatabaseHelper.columnNotifQuedoPegadoNotificacion: quedoPegado,
                                DatabaseHelper.columnNotifMotivoNoEntregaIdNotificacion: motivo,
                                DatabaseHelper.columnNotifFormaConstatacionIdNotificacion: formaConstatacion,
                                DatabaseHelper.columnNotifFecEntregaNotificacion: fechaEntrega,
                                DatabaseHelper.columnNotifNombreRecibioNotificacion: nombre_recibio,
                                DatabaseHelper.columnNotifDijoSerNotificacion: dijoSer,
                                DatabaseHelper.columnTipoDocumentoIdNotificacion: tipoDocumento,
                              };

                              var db = await DatabaseHelper.instance.database;
                              int? query_id;
                              if (notificacionId != null) {
                               query_id = await DatabaseHelper.instance.updateNotificacion(notificacionId!, notificacionRow);
                              } else {
                                query_id = await DatabaseHelper.instance.insertNotificacion(notificacionRow);
                                notificacionId = query_id;
                              }
                              _getInspeccionNotificacion();
                              setState(() {});
                              print(notificacionId);

                              if(query_id is int){
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[800]),
                            child: const Text("Aceptar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
