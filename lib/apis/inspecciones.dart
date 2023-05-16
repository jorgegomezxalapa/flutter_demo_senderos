import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../partials/my_app_bar.dart';

Future<List<Inspeccion>> fetchInspecciones(http.Client client) async {
  const json='[{"id":1,"no_expediente":"EXP00001","fecha_inspeccion":"2023-03-27","nombre_razon_social":"sindicato de Trabajadores de la Industria de la Construcci\u00f3n en General, Similares y Conexos del Estado de Tabasco, Registro","domicilio":"BLVD. CLUB DE GOLF BELLAVISTA NUMERO 14","subtipo_actuacion":"Subtipo de actuaci\u00f3n 0","materia":"Materia 0","alcance":"Alcance 0","inspector_asignado":"Nombre inspector 0"},{"id":2,"no_expediente":"EXP00002","fecha_inspeccion":"2023-04-16","nombre_razon_social":"SINDICATO NACIONAL DE TRABAJADORES DE FORD MOTOR COMPANY Y DE LA INDUSTRIA AUTOMOTRIZ C.T.M,","domicilio":"PROLONGACION XICOTENCATL 2160","subtipo_actuacion":"Subtipo de actuaci\u00f3n 1","materia":"Materia 1","alcance":"Alcance 1","inspector_asignado":"Nombre inspector 1"},{"id":3,"no_expediente":"EXP00003","fecha_inspeccion":"2023-04-12","nombre_razon_social":"SINDICATO DE TRABAJADORES Y EMPLEADOS DE AUTOTRANSPORTES DE SERVICIO P\u00daBLICO SIMILARES Y CONEXOS DEL ESTADO DE CAMPECHE","domicilio":"Ignacio L. Rayon 713","subtipo_actuacion":"Subtipo de actuaci\u00f3n 2","materia":"Materia 2","alcance":"Alcance 2","inspector_asignado":"Nombre inspector 2"},{"id":4,"no_expediente":"EXP00004","fecha_inspeccion":"2023-03-23","nombre_razon_social":"Sindicato nacional de trabajadores y empleados del comercio en general y actividades conexas y similares de la republica mexicana","domicilio":"Tercera Calle Sur 37","subtipo_actuacion":"Subtipo de actuaci\u00f3n 3","materia":"Materia 3","alcance":"Alcance 3","inspector_asignado":"Nombre inspector 3"},{"id":5,"no_expediente":"EXP00005","fecha_inspeccion":"2023-04-13","nombre_razon_social":"SINDICATO DE TRABAJADORES Y EMPLEADOS DE LS INDUSTRIA DE LA CONSTRUCCION","domicilio":"Av. Ricardo flores magon 44","subtipo_actuacion":"Subtipo de actuaci\u00f3n 4","materia":"Materia 4","alcance":"Alcance 4","inspector_asignado":"Nombre inspector 4"},{"id":6,"no_expediente":"EXP00006","fecha_inspeccion":"2023-02-20","nombre_razon_social":"Federacion regional de obreros y campesinos de los municipios de mazatlan, concordia y san ignacio c.t.m.","domicilio":"AUTOPISTA CHAMAPA LECHERIA km12","subtipo_actuacion":"Subtipo de actuaci\u00f3n 5","materia":"Materia 5","alcance":"Alcance 5","inspector_asignado":"Nombre inspector 5"},{"id":7,"no_expediente":"EXP00007","fecha_inspeccion":"2023-03-27","nombre_razon_social":"Sindicato de trabajadores de servicios industriales c.t.m.","domicilio":"LOMA ALTA 121","subtipo_actuacion":"Subtipo de actuaci\u00f3n 6","materia":"Materia 6","alcance":"Alcance 6","inspector_asignado":"Nombre inspector 6"},{"id":8,"no_expediente":"EXP00008","fecha_inspeccion":"2023-03-13","nombre_razon_social":"Asociacion de trabajadores y empleados de la industria quimica, farmaceutica, similares y conexos de la republica mexicana","domicilio":"Privada 24 de Febrero 1220","subtipo_actuacion":"Subtipo de actuaci\u00f3n 7","materia":"Materia 7","alcance":"Alcance 7","inspector_asignado":"Nombre inspector 7"},{"id":9,"no_expediente":"EXP00009","fecha_inspeccion":"2023-05-04","nombre_razon_social":"Sindicato de Trabajadores de la Industria Gastron\u00f3mica, Hoteles, Discotheques, Bares, Centros Recreativos, Prestadores de Servicios en General y Similares del Estado de M\u00e9xico","domicilio":"ANDADOR ISLANDIA 4","subtipo_actuacion":"Subtipo de actuaci\u00f3n 8","materia":"Materia 8","alcance":"Alcance 8","inspector_asignado":"Nombre inspector 8"},{"id":10,"no_expediente":"EXP00010","fecha_inspeccion":"2023-04-30","nombre_razon_social":"SINDICATO DE TRABAJADORES Y EMPLEADOS DEL COMERCIO, HOTELES, RESTAURANTES, CENTROS EDUCATIVOS SIMILARES Y CONEXOS DEL ESTADO DE MEXICO","domicilio":"AVENIDA LUIS DONALDO COLOSIO 5","subtipo_actuacion":"Subtipo de actuaci\u00f3n 9","materia":"Materia 9","alcance":"Alcance 9","inspector_asignado":"Nombre inspector 9"},{"id":11,"no_expediente":"EXP00011","fecha_inspeccion":"2023-03-29","nombre_razon_social":"SINDICATO NACIONAL DE TRABAJORES DE LA CONSTRUCCI\u00d3N, ACARREO DE MATERIALES, OPERACI\u00d3N DE AUTOPISTAS, TRANSPORTE EN GENERAL, COMERCIALIZACI\u00d3N Y SERVICIOS EN GENERAL, SEGURIDAD PRIVADA,HOSPITALES, OFICINAS, ESCUELAS PARTICULARES, QU\u00cdMICO Y PL\u00c1STICO, ACTIVIDADES SIMILARES Y CONEXAS","domicilio":"JESUS GOYTORTUA 370","subtipo_actuacion":"Subtipo de actuaci\u00f3n 10","materia":"Materia 10","alcance":"Alcance 10","inspector_asignado":"Nombre inspector 10"},{"id":12,"no_expediente":"EXP00012","fecha_inspeccion":"2023-04-23","nombre_razon_social":"SINDICATO NACIONAL DE TRABAJADORES DE LA CONSTRUCCI\u00d3N, ACARREO DE MATERIALES, OPERACI\u00d3N DE AUTOPISTAS,TRANSPORTE EN GENERAL,COMERCIALIZACI\u00d3N Y SERVICIOS EN GENERAL,SEGURIDAD PRIVADA,HOSPITALES,OFICINAS,ESCUELAS PARTICULARES,QU\u00cdMICO Y PLASTICO,ACTIVIDADES SIMILARES Y CONEXAS","domicilio":"PROLONGACI\u00d3N SATELITE 750","subtipo_actuacion":"Subtipo de actuaci\u00f3n 11","materia":"Materia 11","alcance":"Alcance 11","inspector_asignado":"Nombre inspector 11"},{"id":13,"no_expediente":"EXP00013","fecha_inspeccion":"2023-04-27","nombre_razon_social":"SINDICATO MEXICANO DE TRABAJADORES DEL CAMPO, ESTABLECIMIENTOS COMERCIALES Y SIMILARES DEL ESTADO DE M\u00c9XICO","domicilio":"REAL DE SAN PEDRO S\/N","subtipo_actuacion":"Subtipo de actuaci\u00f3n 12","materia":"Materia 12","alcance":"Alcance 12","inspector_asignado":"Nombre inspector 12"},{"id":14,"no_expediente":"EXP00014","fecha_inspeccion":"2023-04-08","nombre_razon_social":"SINDICATO UNICO DE TRABAJADORES ACADEMICOS Y ADMINISTRATIVOS DE LA UNIVERSIDAD TECNOLOGICA DE TABASCO","domicilio":"AVENIDA INDUSTRIAS 1234","subtipo_actuacion":"Subtipo de actuaci\u00f3n 13","materia":"Materia 13","alcance":"Alcance 13","inspector_asignado":"Nombre inspector 13"},{"id":15,"no_expediente":"EXP00015","fecha_inspeccion":"2023-02-27","nombre_razon_social":"SINDICATO NACIONAL DE TRABAJADORES EN ESTABLECIMIENTOS COMERCIALES EN GENERAL DE LA REP\u00daBLICA MEXICANA C.T.M.","domicilio":"20 DE NOVIEMBRE 230","subtipo_actuacion":"Subtipo de actuaci\u00f3n 14","materia":"Materia 14","alcance":"Alcance 14","inspector_asignado":"Nombre inspector 14"},{"id":16,"no_expediente":"EXP00016","fecha_inspeccion":"2023-04-13","nombre_razon_social":"SINDICATO DE TRABAJADORES Y EMPLEADOS DE LA INDUSTRIA DEL TRANSPORTE EN GENERAL, TERRACERIA, MATERIALES PETREOS , MEZCLAS ASFALTICAS Y DE LA CONSTRUCCION SIMILARES Y CONEXOS DE LA REPUBLICA MEXICANA","domicilio":"CAPITAN MANUEL PALAU 56","subtipo_actuacion":"Subtipo de actuaci\u00f3n 15","materia":"Materia 15","alcance":"Alcance 15","inspector_asignado":"Nombre inspector 15"},{"id":17,"no_expediente":"EXP00017","fecha_inspeccion":"2023-03-06","nombre_razon_social":"Sindicato de Trabajadores del Autotransporte, Materialistas, Terraceros y de la Industria de la Construcci\u00f3n en General, Similares y Conexos del Estado de San Luis Potos\u00ed","domicilio":"AUTOPISTA CHAMAPA-LECHERIA km 2.5","subtipo_actuacion":"Subtipo de actuaci\u00f3n 16","materia":"Materia 16","alcance":"Alcance 16","inspector_asignado":"Nombre inspector 16"},{"id":18,"no_expediente":"EXP00018","fecha_inspeccion":"2023-03-15","nombre_razon_social":"Sindicato de Industria de Trabajadores de la Manufactura y Confecci\u00f3n de ropa en general del Estado de M\u00e9xico","domicilio":"AV. JUAREZ FRAC. EL MIRADOR 123","subtipo_actuacion":"Subtipo de actuaci\u00f3n 17","materia":"Materia 17","alcance":"Alcance 17","inspector_asignado":"Nombre inspector 17"},{"id":19,"no_expediente":"EXP00019","fecha_inspeccion":"2023-02-10","nombre_razon_social":"SINDICATO NACIONAL  DE EMPLEADOS Y TRABAJADORES DE TRANSPORTE EN GENERAL, CONSTRUCCION Y ACTIVIDAD CONEXAS EN LA REPUB\u00d1ICA MEXICANA","domicilio":"CIRCUITO JARDIN PUSHKIN mz 3 lt 18","subtipo_actuacion":"Subtipo de actuaci\u00f3n 18","materia":"Materia 18","alcance":"Alcance 18","inspector_asignado":"Nombre inspector 18"},{"id":20,"no_expediente":"EXP00020","fecha_inspeccion":"2023-02-17","nombre_razon_social":"Sindicato nacional de la industria de productos electricos y similares de la republica mexicana","domicilio":"5 DE FEBRERO 22","subtipo_actuacion":"Subtipo de actuaci\u00f3n 19","materia":"Materia 19","alcance":"Alcance 19","inspector_asignado":"Nombre inspector 19"}]';
  return compute(parseInspecciones, json);

  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  print("en el servicio");
  print(response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseInspecciones, response.body);
}

// de json a List<Inspecciones>.
List<Inspeccion> parseInspecciones(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Inspeccion>((json) => Inspeccion.fromJson(json)).toList();
}

class Inspeccion {
  final int id;
  final String no_expediente;
  final String fecha_inspeccion;
  final String nombre_razon_social;
  final String domicilio;
  final String subtipo_actuacion;
  final String materia;
  final String alcance;
  final String inspector_asignado;

  const Inspeccion({
    required this.id,
    required this.no_expediente,
    required this.fecha_inspeccion,
    required this.nombre_razon_social,
    required this. domicilio,
    required this. subtipo_actuacion,
    required this. materia,
    required this. alcance,
    required this. inspector_asignado,
  });

  factory Inspeccion.fromJson(Map<String, dynamic> json) {
    return Inspeccion(
      id: json['id'] as int,
      no_expediente: json['no_expediente'] as String,
      fecha_inspeccion: json['fecha_inspeccion'] as String,
      nombre_razon_social: json['nombre_razon_social'] as String,
      domicilio: json['domicilio'] as String,
      subtipo_actuacion: json['subtipo_actuacion'] as String,
      materia: json['materia'] as String,
      alcance: json['alcance'] as String,
      inspector_asignado: json['inspector_asignado'] as String,
    );
  }
}


class InspeccionesService extends StatelessWidget {
  InspeccionesService({super.key});
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Inspecciones',
      ),
      body: FutureBuilder<List<Inspeccion>>(
        future: fetchInspecciones(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error......");
            print(snapshot);
            return const Center(
              child: Text('Ocurrió un error al consumir el servicio!'),
            );
          } else if (snapshot.hasData) {
            //return InspeccionesList(inspecciones: snapshot.data!);
            return InspeccionesTable(inspecciones: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class InspeccionesTable extends StatelessWidget {
  const InspeccionesTable({super.key, required this.inspecciones});

  final List<Inspeccion> inspecciones;

  @override
  Widget build(BuildContext context){
    return DataTable(
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
      rows: inspecciones.map<DataRow>((i){
        return DataRow(
          //key: Key(inspeccionItem.name),
          cells:<DataCell>[
            DataCell(
                Text(i.no_expediente)
            ),
            DataCell(
                Text(i.fecha_inspeccion)
            ),
            DataCell(
                Text(i.nombre_razon_social)
            ),
            DataCell(
                Text(i.domicilio)
            ),
            DataCell(
                Text(i.subtipo_actuacion)
            ),
            DataCell(
                Text(i.materia)
            ),
            DataCell(
                Text(i.alcance)
            ),
            DataCell(
                Text(i.inspector_asignado)
            )
          ],
        );
      }).toList(),
    );
  }

/*Future<void> downloadFormulario(Photo foto) async {
    final item = Formulario(
      id: foto.id,
      nombre: foto.title,
    );
    print("aa");
    print(item.id);
    await Operation.insertFormulario(item);
    print("formulario agregado");
  }*/
}