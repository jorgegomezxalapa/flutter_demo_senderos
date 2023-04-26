import 'package:flutter/material.dart';

import '../../database/handler/database_helper.dart';

class PersonasList extends StatefulWidget {
  const PersonasList({super.key});

  @override
  _PersonasListState createState() => _PersonasListState();
}

class _PersonasListState extends State<PersonasList> {
  List<Map<String, dynamic>> _registros = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;

    // Consulta todos los registros de la tabla personas
    List<Map<String, Object?>>? registros =
        await db?.query(DatabaseHelper.table);

    // Actualiza el estado del widget con los registros obtenidos
    setState(() {
      _registros = registros!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _registros.length,
      itemBuilder: (context, index) {
        var nombreCompleto = _registros[index][DatabaseHelper.columnNombre]+" "+_registros[index][DatabaseHelper.columnPrimerApellido]+" "+_registros[index][DatabaseHelper.columnSegundoApellido];
        var datosComplementarios = "Edad: ${_registros[index][DatabaseHelper.columnEdad]} |  Género: ${_registros[index][DatabaseHelper.columnGenero]} ";
        return ListTile(
          title: Text(nombreCompleto ),
          subtitle: Text(datosComplementarios),
        );
      },
    );
  }
}
