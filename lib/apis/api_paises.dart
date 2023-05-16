import 'package:demo_senderos/apis/lista_paises.dart';

import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

class ApiPaises extends StatefulWidget {
  String? titulo = 'Api Paises';
  ApiPaises({super.key});

  @override
  ApiPaisesState createState() => ApiPaisesState();
}

class ApiPaisesState extends State<ApiPaises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      body: const ListaPaises(),
    );
  }
}
