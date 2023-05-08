import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:demo_senderos/apis/api_paises.dart';
import 'package:demo_senderos/formularios/modulo_persona.dart';
import 'package:demo_senderos/partials/my_app_bar.dart';
import 'package:flutter/material.dart';



Future main() async {
  if (Platform.isWindows) {
    // Initialize FFI
    ffi.sqfliteFfiInit();
    // Change the default factory
    databaseFactory = ffi.databaseFactoryFfi;
  }
  runApp(const MaterialApp(
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
  void _routeApiPaises() { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApiPaises())); }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'HomePage', btnRegresar: false,),
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
                    'Api Paises',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),),
                  leading: const Icon(
                    Icons.flag_circle_sharp,
                    size: 25,
                  ),
                  onTap: _routeApiPaises,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
