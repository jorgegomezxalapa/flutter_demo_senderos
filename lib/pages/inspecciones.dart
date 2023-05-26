import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:air_senderos/pages/formulario_datos_generales.dart';
import 'package:air_senderos/pages/widgets/component_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:air_senderos/main.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:air_senderos/resources/scripts/general.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:air_senderos/resources/designs/styles.dart';


// Definir el proveedor
final counterProvider = Provider<Counter>((ref) => Counter());

class Counter {
  int counter = 10;
  void increment() => counter++;
}

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Consumer(
              builder: (context, ref, _) {
                final properties = ref.watch(propertiesProvider) as Properties;
                var isOnline = properties.isOnline;
                var isLoading = properties.isLoading;
                var version = properties.version;
                var haveCredentials = properties.haveCredentials;
                var usuarioActivo = properties.usuarioActivo;
                return AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromARGB(250, 35, 91, 78),
                  title: Text(AppLocalizations.of(context).appBar(version)),
                  actions: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 0),
                      child: Text(
                        textAlign: TextAlign.right,
                        "¡Bienvenidx!\n$usuarioActivo",
                      ),
                    ),
                    IconButton(
                      icon: isOnline
                          ? const Icon(
                        Icons.cloud_upload,
                        size: 35,
                      )
                          : const Icon(
                        Icons.cloud_off,
                        size: 35,
                      ),
                      tooltip: 'Sincronizar',
                      onPressed: () {
                        sincronize(context, ref);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.person_off,
                        size: 35,
                      ),
                      tooltip: 'Cerrar sesión',
                      onPressed: () {
                        logout(context, ref, haveCredentials);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 35,
                      ),
                      tooltip: 'Finalizar aplicación',
                      onPressed: () {
                        closing(context);
                      },
                    ),
                  ],
                );
              }),
      ),
      body: SafeArea(
        child:Consumer(
            builder: (context, ref, _) {
              final properties = ref.watch(propertiesProvider) as Properties;
              var isOnline = properties.isOnline;
              var isLoading = properties.isLoading;
              var version = properties.version;
              var haveCredentials = properties.haveCredentials;
              var usuarioActivo = properties.usuarioActivo;
              return ModalProgressHUD(
                inAsyncCall: isLoading,
                // demo of some additional parameters
                opacity: 0.5,
                blur: 5,
                progressIndicator: const ComponentProgressIndicator(
                  title: '¡Espere un momento!',
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Mis inspecciones',
                                  style: titleText,
                                )
                              ],
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
              );
            }),

      ),
    );
  }
}
