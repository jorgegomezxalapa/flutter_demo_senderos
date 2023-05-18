import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'lista_inspecciones.dart';

class ApiInspecciones extends StatefulWidget {
  String? titulo = 'Api Inspecciones';
  ApiInspecciones({super.key});

  @override
  ApiInspeccionesState createState() => ApiInspeccionesState();
}

class ApiInspeccionesState extends State<ApiInspecciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      body: const ListaInspecciones(),
    );
  }
}
