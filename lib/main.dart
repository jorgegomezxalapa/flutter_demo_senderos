import 'package:demo_senderos/formularios/modulo_direccion.dart';
import 'package:demo_senderos/formularios/modulo_persona.dart';
import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter App',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _routeFormularioPersona() { Navigator.of(context) .push(MaterialPageRoute(builder: (context) => ModuloPersona())); }
  void _routeFormularioDireccion() { Navigator.of(context) .push(MaterialPageRoute(builder: (context) => ModuloDireccion())); }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'HomePage',),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlutterLogo(
                style: FlutterLogoStyle.horizontal,
                size: 180,
              ),
              const Text(
                'Selecciona un Formulario',
                style: TextStyle(
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                      'Formulario Persona',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5
                  ),),
                  leading: const Icon(
                    Icons.person_add,
                    size: 25,
                  ),
                  onTap: _routeFormularioPersona,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Formulario Ubicación',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.add_location,
                    size: 25,
                  ),
                  onTap: _routeFormularioDireccion,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
