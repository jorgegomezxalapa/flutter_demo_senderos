import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:air_senderos/pages/formulario_datos_generales.dart';
import 'package:flutter/material.dart';

class ModuloInspeccion extends StatefulWidget {
  String? titulo = 'Mis inspecciones';
  ModuloInspeccion({super.key});

  @override
  ModuloInspeccionState createState() => ModuloInspeccionState();
}

class ModuloInspeccionState extends State<ModuloInspeccion> {

  List<Map<String, dynamic>> _inspecciones = [];

  Future<void> _getInspecciones() async {
    // Inicializa la base de datos
    var db = await DatabaseHelper.instance.database;
    // Consulta todos los registros de la tabla personas
    List<Map<String, Object?>>? inspecciones =
    await db?.query(DatabaseHelper.tableInspeccion);
    _inspecciones = inspecciones ?? [];
    // Actualiza el estado del widget con los registros obtenidos
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getInspecciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                  Theme(
                    data: Theme.of(context).copyWith(
                      dataTableTheme:  DataTableThemeData(
                        decoration: BoxDecoration(color: Colors.yellow.shade100), // Selecciona el color aquí
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(width: 1),
                        columnSpacing: 10,
                        dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                          }
                          return Colors.white; // Selecciona el color aquí
                        }),
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
                        rows: _inspecciones.map((inspeccion) {
                          var inspeccion_id = inspeccion[DatabaseHelper.columnInspeccionIdInspeccion];
                          var fecha_inspeccion = inspeccion[DatabaseHelper.columnInFecInspeccionInspeccion];
                          var nombre_razon_social = inspeccion[DatabaseHelper.columnInCtRazonSocialInspeccion];
                          var domicilio = inspeccion[DatabaseHelper.columnInDomicilioInspeccionInspeccion];
                          var subtipo_actuacion_id = inspeccion[DatabaseHelper.columnSubtipoInspeccionIdInspeccion];
                          var subtipo_actuacion = 'Extraordinaria';
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
                          int materia_id = inspeccion[DatabaseHelper.columnMateriaIdInspeccion];
                          var materia = '';
                          switch (materia_id) {
                            case 1:
                              materia = 'SH';
                              break;
                            case 2:
                              materia = 'CGT';
                              break;
                            case 3:
                              materia = 'CA';
                              break;
                            case 4:
                              materia = 'CGT';
                              break;
                            case 5:
                              materia = 'SH';
                              break;
                            default:
                              materia = 'SH';
                          }
                          return DataRow(
                            cells: <DataCell>[
                               DataCell(
                                 ConstrainedBox(
                                   constraints: const BoxConstraints(maxWidth: 350),
                                   child: Text(fecha_inspeccion, overflow: TextOverflow.ellipsis),
                                 ),
                               ),
                              DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 350),
                                    child: Text(nombre_razon_social, overflow: TextOverflow.ellipsis),
                                  ),
                              ),
                              DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 350),
                                    child: Text(domicilio, overflow: TextOverflow.ellipsis),
                                  ),
                              ),
                              DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 350),
                                    child: Text(subtipo_actuacion, overflow: TextOverflow.ellipsis),
                                  ),
                              ),
                              DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 350),
                                    child: Text(materia, overflow: TextOverflow.ellipsis),
                                  ),
                              ),
                              DataCell(
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => FormularioDatosGenerales(inspeccionId:inspeccion_id),
                                              ),
                                            );
                                          },
                                          child: const Text('Seleccionar',
                                            style: TextStyle(
                                                decoration: TextDecoration.underline
                                            ),),
                                        ),
                                      ),
                                      const Icon(Icons.cloud_upload_outlined),
                                    ],
                                  ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
