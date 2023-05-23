import 'package:flutter/material.dart';

class FormularioDireccion extends StatefulWidget {
  const FormularioDireccion({super.key});
  @override
  FormularioDireccionState createState() => FormularioDireccionState();
}

class FormularioDireccionState extends State<FormularioDireccion> {
  final _formKey = GlobalKey<FormState>();
  String _calle = '';
  int _numero = 0;
  String _colonia = '';
  int _codigoPostal = 0;
  String _estado = '';

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
                initialValue: _calle,
                decoration: const InputDecoration(labelText: 'Calle'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa la calle';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _calle = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _numero.toString(),
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa el número';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _numero = int.parse(value!)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _colonia,
                decoration: const InputDecoration(labelText: 'Colonia'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa la colonia';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _colonia = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _codigoPostal.toString(),
                decoration: const InputDecoration(labelText: 'Código Postal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa el código postal';
                  }
                  return null;
                },
                onSaved: (value) =>
                    setState(() => _codigoPostal = int.parse(value!)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _estado,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Por favor ingresa el estado';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _estado = value!),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
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
