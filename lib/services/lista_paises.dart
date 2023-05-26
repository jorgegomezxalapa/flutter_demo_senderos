import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ListaPaises extends StatefulWidget {
  const ListaPaises({super.key});

  @override
  ListaPaisesState createState() => ListaPaisesState();
}

class ListaPaisesState extends State<ListaPaises> {
  final dbHelper = DatabaseHelper.instance;
  late Future<List<Map<String, dynamic>>> _paisesFuture;

  bool _hasConnection2 = false;
  late List data;
  var contenido;
  var _registros;

  Future<void> _localData() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;

    // Consulta todos los registros de la tabla personas
    List<Map<String, Object?>>? registros =
        await db?.query(DatabaseHelper.tablePersonas);

    // Actualiza el estado del widget con los registros obtenidos
    setState(() {
      _registros = registros!;
    });
  }

  Future<String> getData() async {
    if (!_hasConnection2) {
      contenido = [];
    } else {
      var response = await http.get(
          Uri.parse("https://restcountries.com/v3.1/region/america"),
          headers: {"Accept": "application/json"});
      contenido = json.decode(response.body);
    }
    setState(() {
      data = contenido;
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    _paisesFuture = dbHelper.queryAllPaises();
    data = [];

    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnection();
    });
    getData();
    _localData();
    _paisesFuture = dbHelper.queryAllPaises();
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return _hasConnection2
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(data[index]['name']['common']),
                ),
              );
            })
        : FutureBuilder<List<Map<String, dynamic>>>(
            future: _paisesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            snapshot.data![index][DatabaseHelper.columnCommon]),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
  }
}
