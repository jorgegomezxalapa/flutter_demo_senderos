import 'dart:io' show Platform;
import 'package:demo_senderos/apis/api_inspecciones.dart';
import 'package:demo_senderos/formularios/formulario_datos_generales.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:demo_senderos/apis/api_paises.dart';
import 'package:demo_senderos/formularios/modulo_persona.dart';
import 'package:demo_senderos/partials/my_app_bar.dart';

import 'apis/bandeja_inspecciones.dart';
import 'apis/lista_inspecciones.dart';


Future main() async {
  if (Platform.isWindows) {
    // Initialize FFI
    ffi.sqfliteFfiInit();
    // Change the default factory
    databaseFactory = ffi.databaseFactoryFfi;
  }
  runApp(const MaterialApp(
    title: 'Flutter App',
    home: MyApp(),
  ));
}

/*
//clase de cada elemento de la tabla
class ComidaItem{
  final String name;
  final int calories;

  ComidaItem(this.name, this.calories);
}

//valores de la lista
final List<ComidaItem> _comidasList = [
  ComidaItem("Yogurt", 87),
  ComidaItem("Hamburguesa de macdonals", 1500),
  ComidaItem("Hamburguesa BK", 1200),
  ComidaItem("Sandia", 100),
  ComidaItem("Galletas", 300),
];

//widget de la tabla
Widget _buildTable({bool sortAscending = true}){
  return DataTable(
    sortColumnIndex: 0,
      sortAscending: sortAscending,
      onSelectAll: (value) {},
      columns: <DataColumn>[
         const DataColumn(
            label: Text('Nombre'),
            tooltip: 'Nombre'
        ),
        DataColumn(
            label: const Text('Calorias'),
          tooltip: 'Calorias',
          numeric: true,
          onSort: (int columnIndex, bool ascending) {},
        )
      ],
      rows: _comidasList.map<DataRow>((ComidaItem comidaItem){
        return DataRow(
          //key: Key(comidaItem.name),
          onSelectChanged: (selected) {},
          cells:<DataCell>[
            DataCell(
              Text(comidaItem.name)
            ),
          DataCell(
            Text('${comidaItem.calories}'),
            showEditIcon: true,
            onTap: () {},
          )
          ],
        );
      }).toList(),
  );
}
*/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _routeFormularioPersona() { Navigator.of(context) .push(MaterialPageRoute(builder: (context) => ModuloPersona())); }
  void _routeApiPaises() { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApiPaises())); }
  void _routeFormularioDatosGenerales(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FormularioDatosGenerales()
      )
    );
  }
  void _routeInspecciones() { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApiInspecciones())); }
  void _routeInspeccionesDataTables() { Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataPage())); }
  void _routeInspeccionesLista() { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListaInspecciones())); }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'HomePage', btnRegresar: false,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlutterLogo(
                style: FlutterLogoStyle.horizontal,
                size: 180,
              ),
              const Text(
                'Selecciona un Formulario',
                style: TextStyle(
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                      'Formulario Persona',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5
                  ),),
                  leading: const Icon(
                    Icons.person_add,
                    size: 25,
                  ),
                  onTap: _routeFormularioPersona,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Api Paises',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.flag_circle_sharp,
                    size: 25,
                  ),
                  onTap: _routeApiPaises,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Formulario Datos Generales',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.flag_circle_sharp,
                    size: 25,
                  ),
                  onTap: _routeFormularioDatosGenerales,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                  'Inspecciones',
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                  ),),
                leading: const Icon(
                  Icons.flag_circle_sharp,
                  size: 25,
                ),
                onTap: _routeInspecciones,
              ),
            ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Inspecciones Datatables',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.flag_circle_sharp,
                    size: 25,
                  ),
                  onTap: _routeInspeccionesDataTables,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Inspecciones lista',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.flag_circle_sharp,
                    size: 25,
                  ),
                  onTap: _routeInspeccionesLista,
                ),
              ),
              /*Center(
                child: _buildTable(sortAscending: true),
              )*/
            ],
          ),
        ),
      )
    );
  }
}

