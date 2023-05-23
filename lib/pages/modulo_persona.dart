import 'package:air_senderos/pages/lista_personas.dart';
import 'package:air_senderos/pages/widgets/formulario_persona.dart';

import 'package:air_senderos/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class ModuloPersona extends StatefulWidget {
  String? titulo = 'Formulario Persona';
  ModuloPersona({super.key});

  @override
  ModuloPersonaState createState() => ModuloPersonaState();
}

class ModuloPersonaState extends State<ModuloPersona> {
  void _routeListaPersonas() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ListaPersonas()));
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.titulo ?? "Formulario",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.4,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: _routeListaPersonas,
                  child: const Text('Ver lista de personas')),
              const SizedBox(
                height: 20,
              ),
              const FormularioPersona(),
            ],
          ),
        ),
      ),
    );
  }
}
