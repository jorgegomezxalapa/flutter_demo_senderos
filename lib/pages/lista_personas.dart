import 'package:air_senderos/pages/widgets/personas.dart';
import 'package:air_senderos/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class ListaPersonas extends StatefulWidget {
  String? titulo = 'Formulario Persona';
  ListaPersonas({super.key});

  @override
  ListaPersonasState createState() => ListaPersonasState();
}

class ListaPersonasState extends State<ListaPersonas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      body: const PersonasList(),
    );
  }
}
