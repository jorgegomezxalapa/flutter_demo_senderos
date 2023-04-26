import 'package:demo_senderos/formularios/partials/formulario_direccion.dart';
import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

class ModuloDireccion extends StatefulWidget {
  String? titulo = 'Formulario Dirección';
  ModuloDireccion({super.key});

  @override
  ModuloDireccionState createState() => ModuloDireccionState();
}

class ModuloDireccionState extends State<ModuloDireccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.titulo,
      ),
      body: SingleChildScrollView(
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
            const FormularioDireccion(),
          ],
        ),
      ),
    );
  }
}
