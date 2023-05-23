
import 'package:demo_senderos/formularios/lista_personas.dart';
import 'package:demo_senderos/formularios/partials/formulario_persona.dart';

import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

class ModuloInspeccion extends StatefulWidget {
  String? titulo = 'Mis inspecciones';
  ModuloInspeccion({super.key});

  @override
  ModuloInspeccionState createState() => ModuloInspeccionState();
}

class ModuloInspeccionState extends State<ModuloInspeccion> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.titulo ?? "Formulario",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Fecha de inspección',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nombre o razón social',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Domicilio',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Subtipo de actuación',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Materia',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Acciones',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2023-05-23')),
                          DataCell(Text('Empresa A')),
                          DataCell(Text('Calle A #123')),
                          DataCell(Text('Subtipo 1')),
                          DataCell(Text('Materia 1')),
                          DataCell(Text('Acción 1')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2023-05-24')),
                          DataCell(Text('Empresa B')),
                          DataCell(Text('Calle B #456')),
                          DataCell(Text('Subtipo 2')),
                          DataCell(Text('Materia 2')),
                          DataCell(Text('Acción 2')),
                        ],
                      ),
                    ],
                  ),
                ],
              )

            ],
          )
        ),
      ),
    );
  }
}
