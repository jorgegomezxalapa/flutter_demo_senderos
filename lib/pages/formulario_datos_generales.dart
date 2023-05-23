import 'package:demo_senderos/partials/cargar_documento_widget.dart';
import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

class FormularioDatosGenerales extends StatefulWidget {

  String? titulo = 'Formulario Datos Generales';
  FormularioDatosGenerales({super.key});

  @override
  FormularioDatosGeneralesState createState() =>
      FormularioDatosGeneralesState();
}

class FormularioDatosGeneralesState extends State<FormularioDatosGenerales> {

  @override
  void initState() {
    super.initState();
  }
  String _radioRecibioEmpresa = 'Sí';
  String _radioSeDejoPegado = 'Sí';
  String _selectedOptionMotivo = '--Seleccionar--';
  String _selectedOptionFDCDRSYD = '--Seleccionar--';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? radioDocumentoPorGenerar = "elemento_1";

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
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      //contenedor principal
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: SafeArea(
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
                                child: Text(
                                  'Normatividad Pruebas QA',
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
                                    Text('JANEL S.A. DE C.V.'),
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
                                    Text(
                                      'LAGO ZURICH PLAZA CARSO No. 245, Interior 14, Colonia AMPLIACION GRANADA C.P. 11529, MIGUEL HIDALGO, DISTRITO FEDERAL,.',
                                    ),
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
                                    const Text(
                                        '2 febrero 2023 Hora 01:00 p.m.'),
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
                                    Text('221/000028/2023'),
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
                                    const Text('Extraordinaria'),
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
                                    const Text('Extraordinaria'),
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
                                    const Text(
                                        'Condiciones generales de trabajo'),
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
                                    const Text('Específico'),
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
                                    const Text('Sí'),
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
                                        child: DropdownButton(
                                          value: _selectedOptionMotivo,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedOptionMotivo = newValue!;
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
                                      value: _selectedOptionFDCDRSYD,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedOptionFDCDRSYD = newValue!;
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
                        IntrinsicHeight(
                          child: Row(
                            children: const [
                               Expanded(
                                flex: 1,
                                child:  CargarDocumentoWidget(titleText: 'Orden de inspección',),
                              ),
                               Expanded(
                                flex: 1,
                                child:  CargarDocumentoWidget(titleText: 'Citatorio',),
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
                        IntrinsicHeight(
                          child: Row(
                            children: const [
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
                        IntrinsicHeight(
                          child: Row(
                            children: const [],
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
                    SizedBox(
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
                          onPressed: () {
                            // Acción al presionar el botón "Aceptar"
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
    );
  }
}
