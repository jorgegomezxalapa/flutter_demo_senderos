
import 'package:demo_senderos/database/handler/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ListaInspecciones extends StatefulWidget {

  const ListaInspecciones({super.key});

  @override
  ListaInspeccionesState createState() => ListaInspeccionesState();
}

class ListaInspeccionesState extends State<ListaInspecciones> {

  final dbHelper = DatabaseHelper.instance;
  late Future<List<Map<String, dynamic>>> _inspeccionesFuture;

  bool _hasConnection2 = false;
  late List data;
  var contenido;
  var _registros;


  Future<void> _localData() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;

    // Consulta todos los registros de la tabla inspecciones
    List<Map<String, Object?>>? registros =
    await db?.query(DatabaseHelper.tableInspecciones);

    // Actualiza el estado del widget con los registros obtenidos
    setState(() {
      _registros = registros!;
    });

  }

  @override
  void initState() {
    super.initState();
    _inspeccionesFuture = dbHelper.queryAllInspecciones();
    data = [];

    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnection();
    });
    _localData();
    _inspeccionesFuture = dbHelper.queryAllInspecciones();
  }

  void _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.other) {
      setState(() {
        _hasConnection2 = true;
      });
    } else {
      setState(() {
        _hasConnection2 = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder<List<Map<String, dynamic>>>(
      future: _inspeccionesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return   DataTable(
              columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.1,
              dataRowHeight: 80,
              sortColumnIndex: 0,
              sortAscending: true,
              onSelectAll: (value) {},
              columns: const <DataColumn>[
                DataColumn(
                    label: Text('Número de expediente'),
                    tooltip: 'Número de expediente'
                ),
                DataColumn(
                    label: Text('Fecha de inspección'),
                    tooltip: 'Fecha de inspección'
                ),
                DataColumn(
                  label: Text('Nombre o razón social'),
                  tooltip: 'Nombre o razón social',
                ),
                DataColumn(
                  label: Text('Domicilio'),
                  tooltip: 'Domicilio',
                ),
                DataColumn(
                  label: Text('Subtipo de actuación'),
                  tooltip: 'Subtipo de actuación',
                ),
                DataColumn(
                  label: Text('Materia'),
                  tooltip: 'Materia',
                ),
                DataColumn(
                  label: Text('Alcance'),
                  tooltip: 'Alcance',
                ),
                DataColumn(
                  label: Text('Inspector asignado'),
                  tooltip: 'Inspector asignado',
                )

              ],
              rows: snapshot.data!.map<DataRow>((i){
                return DataRow(
                  //key: Key(i.id),
                  cells:<DataCell>[
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['no_expediente']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['fecha_inspeccion']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['nombre_razon_social']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['domicilio']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['subtipo_actuacion']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['materia']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['alcance']))),
                    DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 3, child: Text(i['inspector_asignado']))),
                  ],
                );
              }).toList(),
            );

          /*return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data![index][DatabaseHelper.columnNoExpediente]),
                ),
              );
            },
          );*/
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

