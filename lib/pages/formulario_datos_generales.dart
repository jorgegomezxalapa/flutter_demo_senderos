import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:air_senderos/widgets/cargar_documento_widget.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _getInspeccion();
  }

  //variables de consulta
  String normatividad= '';
  int? normatividadId;
  String nombreRazonSocial= '';
  String domicilio = '';
  String fechaInspeccion = '';
  String expediente = '';
  String tipoActuacion = ''; // no se encuentra en la db
  int? subtipo_actuacion_id;
  String? subtipo_actuacion;
  int? materia_id;
  String tipoMateria = '';
  int? alcance_id;
  String alcance = '';
  String expidioCitatorio = '';
  int? expidioCitatorio_id;

  //variables del formulario
  final _formularioDatosGenerales = GlobalKey<FormState>();
  final _nombreRecibioController = TextEditingController();
  final _dijoSerController = TextEditingController();
  String _radioRecibioEmpresa = 'Sí';
  String _radioSeDejoPegado = 'Sí';
  String _selectedOptionMotivo = '--Seleccionar--';
  String _selectedOptionFormaConstatacion = '--Seleccionar--';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? radioDocumentoPorGenerar = "elemento_1";

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
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_inspeccion.isNotEmpty){
      return const CircularProgressIndicator();
    }else{
       normatividadId = _inspeccion.first[DatabaseHelper.columnNormativaVersionIdInspeccion];
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
       nombreRazonSocial = _inspeccion.first[DatabaseHelper.columnInCtRazonSocialInspeccion];
       domicilio = _inspeccion.first[DatabaseHelper.columnInDomicilioInspeccionInspeccion];
       fechaInspeccion = _inspeccion.first[DatabaseHelper.columnInFecInspeccionInspeccion];
       expediente = _inspeccion.first[DatabaseHelper.columnInNumExpedienteInspeccion];
       tipoActuacion = 'Extraordinaria'; // no se encuentra en la db
       subtipo_actuacion_id = _inspeccion.first[DatabaseHelper.columnSubtipoInspeccionIdInspeccion];
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
       expidioCitatorio_id = _inspeccion.first[DatabaseHelper.columnInGenerarCitatorioInspeccion];
       expidioCitatorio =(expidioCitatorio_id == 1) ? 'Sí' : 'No';
    }
    return Scaffold(
      //contenedor principal
      body: SingleChildScrollView(
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
                                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                                  child: Text(
                                    'Normatividad:',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  child: Text(normatividad,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre o razón social',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(nombreRazonSocial),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Domicilio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(domicilio),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fecha de inspección',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(fechaInspeccion),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No. de expediente',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(expediente),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tipo de actuación',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(tipoActuacion),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tipo materia',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(tipoMateria),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alcance',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(alcance),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Se expidió citatorio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(expidioCitatorio),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            value: 'Sí',
                                            groupValue: _radioRecibioEmpresa,
                                            onChanged: (value) {
                                              setState(() {
                                                _radioRecibioEmpresa = value!;
                                              });
                                            },
                                          ),
                                          const Text('Sí'),
                                          Radio(
                                            value: 'No',
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
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: _radioRecibioEmpresa == 'No',
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
                                              value: 'Sí',
                                              groupValue: _radioSeDejoPegado,
                                              onChanged: (value) {
                                                setState(() {
                                                  _radioSeDejoPegado = value!;
                                                });
                                              },
                                            ),
                                            const Text('Sí'),
                                            Radio(
                                              value: 'No',
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
                            visible: _radioRecibioEmpresa == 'No',
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
                                          child: FormField<String>(
                                            builder: (FormFieldState<String> state) {
                                              return DropdownButton(
                                                value: _selectedOptionMotivo,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    _selectedOptionMotivo = newValue!;
                                                  });
                                                  state.didChange(newValue);
                                                },
                                                items: <String>[
                                                  '--Seleccionar--',
                                                  'Motivo uno',
                                                  'Motivo dos',
                                                  'Motivo tres'
                                                ].map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                              );
                                            },
                                            validator: (value) {
                                              /*if (value == null || value == '--Seleccionar--') {
                                                return 'Por favor selecciona una opción';
                                              }
                                              return null;
                                              */
                                            }
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
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Forma de constatación de razón social y domicilio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: _selectedOptionFormaConstatacion,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedOptionFormaConstatacion = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          '--Seleccionar--',
                                          'Motivo uno',
                                          'Motivo dos',
                                          'Motivo tres'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: _radioRecibioEmpresa == 'Sí',
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
                                              key: const Key('_nombreRecibioController'),
                                              controller: _nombreRecibioController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
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
                                  visible: _radioRecibioEmpresa == 'Sí',
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
                                              key: const Key('_dijoSerController'),
                                              controller: _dijoSerController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
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
                                  visible: _radioRecibioEmpresa != 'Sí',
                                  child: Expanded(
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
                                            (_selectedDate != null && _selectedTime != null) 
                                                ?
                                                Text('Selected: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} ${_selectedTime.hour}:${_selectedTime.minute}')
                                                :
                                            const Text(
                                                'Fecha y hora de entrega*'),
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
                                ),
                                Visibility(
                                  visible: _radioRecibioEmpresa != 'Sí',
                                  child: const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
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
                      Visibility(
                        visible: _radioRecibioEmpresa == 'Sí',
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        const Text('Fecha y hora de entrega*'),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    _selectDate(context),
                                                child: const Text('Fecha'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
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
                              children:  [
                                 Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(titleText: 'Orden de inspección',),
                                ),
                                 Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(titleText: 'Citatorio',),
                                ),
                                 Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(titleText: 'Listado anexo de documentos',),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IntrinsicHeight(
                            child: Row(
                              children:  [
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(titleText: 'Guía de derechos y obligaciones',),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CargarDocumentoWidget(titleText: 'Doc_ARCR_Programación',),
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
                              children:  [],
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
                              value: "elemento_1",
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Acta de inspección"),
                              value: "elemento_2",
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Negativa patronal"),
                              value: "elemento_3",
                              groupValue: radioDocumentoPorGenerar,
                              onChanged: (value) {
                                setState(() {
                                  radioDocumentoPorGenerar = value;
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
                                // Acción al presionar el botón "Cancelar"
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
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              //_formularioDatosGenerales.currentState != null && _formularioDatosGenerales.currentState!.validate()
                              if (true) {
                                // Guardar el valor en la base de datos
                                final recibio_empresa = _radioRecibioEmpresa;
                                final quedo_pegado = _radioSeDejoPegado;
                                final nombre_recibio = _nombreRecibioController.text;
                                final dijo_ser = _dijoSerController.text;
                                final forma_constatacion = _selectedOptionFormaConstatacion;
                                final motivo = _selectedOptionMotivo;
                                final fec_entrega = '${_selectedDate.toLocal().toString().split(' ')[0]} ${_selectedTime.hour}:${_selectedTime.minute}';
                                final tipo_documento = radioDocumentoPorGenerar;

                                var db = await DatabaseHelper.instance.database;

                                // Inserta un registro en la tabla personas
                                int? id = await DatabaseHelper.instance.insertNotificacion({
                                  DatabaseHelper.columnNotifSeRecibioNotificacion: recibio_empresa,
                                  DatabaseHelper.columnNotifQuedoPegadoNotificacion: quedo_pegado,
                                  DatabaseHelper.columnNotifNombreRecibioNotificacion: nombre_recibio,
                                  DatabaseHelper.columnNotifDijoSerNotificacion: dijo_ser,
                                  DatabaseHelper.columnNotifFormaConstatacionIdNotificacion: forma_constatacion,
                                  DatabaseHelper.columnNotifOtroMotivoNotificacion: motivo,
                                  DatabaseHelper.columnNotifFecEntregaNotificacion: fec_entrega,
                                  DatabaseHelper.columnTipoDocumentoIdNotificacion: tipo_documento,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[800]),
                            child: const Text("Aceptar"),
                          ),
                        ],
                      )
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
