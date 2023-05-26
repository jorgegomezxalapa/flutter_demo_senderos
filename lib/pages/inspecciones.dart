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

  List<DataColumn> buildDataColumns() {
    return const <DataColumn>[
      DataColumn(
        label: Expanded(
          child: Text(
            'Fecha de inspección',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Nombre o razón social',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Domicilio',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Subtipo de actuación',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Materia',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Acciones',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
  }


  List<DataRow> generateDataRows(List<Map<String, Object?>> inspecciones) {

    return inspecciones.map((inspeccion) {
      String inspeccionId = inspeccion[DatabaseHelper.columnInspeccionIdInspeccion].toString();
      int inspeccion_id = int.parse(inspeccionId);
      var fecha_inspeccion = inspeccion[DatabaseHelper.columnInFecInspeccionInspeccion].toString();
      var nombre_razon_social = inspeccion[DatabaseHelper.columnInCtRazonSocialInspeccion].toString();
      var domicilio = inspeccion[DatabaseHelper.columnInDomicilioInspeccionInspeccion].toString();
      String subtipoActuacionId = inspeccion[DatabaseHelper.columnSubtipoInspeccionIdInspeccion].toString();
      var subtipo_actuacion_id = int.parse(subtipoActuacionId);
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
      String materiaId = inspeccion[DatabaseHelper.columnMateriaIdInspeccion].toString();
      int materia_id = int.parse(materiaId);
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
        cells: [
          DataCell(Text(fecha_inspeccion)),
          DataCell(Text(nombre_razon_social)),
          DataCell(Text(domicilio)),
          DataCell(Text(subtipo_actuacion)),
          DataCell(Text(materia)),
          DataCell(
              Wrap(
                children: [
                  GestureDetector(
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
                  const Icon(Icons.cloud_upload_outlined),
                ],
              ),
          ),
          // Agrega más DataCell según tus necesidades
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mis inspecciones',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FractionallySizedBox(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: DataTableTheme(
                      data: DataTableThemeData(
                        headingRowColor: MaterialStateColor.resolveWith((states) {
                          return const Color(0xFFEFEBDD); // Reemplaza el valor con tu color personalizado
                        }),
                        dividerThickness: 2.0, // Ajusta el grosor del borde inferior según sea necesario

                      ),
                      child: DataTable(
                        columns: buildDataColumns(),
                        rows: generateDataRows(_inspecciones),
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
