import 'package:flutter/material.dart';
import 'package:air_senderos/database/handler/database_helper.dart';

class FormularioPersona extends StatefulWidget {
  const FormularioPersona({super.key});

  @override
  FormularioPersonaState createState() => FormularioPersonaState();
}

class FormularioPersonaState extends State<FormularioPersona> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _primerApellido = '';
  String _segundoApellido = '';
  int _edad = 0;
  String _genero = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _nombre = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _primerApellido,
                decoration: const InputDecoration(labelText: 'Primer Apellido'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa tu primer apellido';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _primerApellido = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _segundoApellido,
                decoration:
                    const InputDecoration(labelText: 'Segundo Apellido'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa tu segundo apellido';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _segundoApellido = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _edad.toString(),
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa tu edad';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _edad = int.parse(value!)),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: _genero,
                decoration: const InputDecoration(labelText: 'Género'),
                items: ['', 'Masculino', 'Femenino']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _genero = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final snackBar = SnackBar(
                    content: const Text('Persona registrada'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Inicializa la base de datos
                    var db = await DatabaseHelper.instance.database;

                    // Inserta un registro en la tabla personas
                    int? id = await DatabaseHelper.instance.insert({
                      DatabaseHelper.columnNombre: _nombre,
                      DatabaseHelper.columnPrimerApellido: _primerApellido,
                      DatabaseHelper.columnSegundoApellido: _segundoApellido,
                      DatabaseHelper.columnEdad: _edad.toInt(),
                      DatabaseHelper.columnGenero: _genero,
                    });

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Guardar formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
