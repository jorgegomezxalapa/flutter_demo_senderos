import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
//Paquete air_senderos
import 'package:air_senderos/main.dart';
import 'package:air_senderos/resources/designs/colors.dart';
import 'package:air_senderos/resources/designs/styles.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/routes/login_route.dart';
import 'package:air_senderos/database/handler/database_helper.dart';

import 'dart:developer';

void sincronize(BuildContext context, WidgetRef ref) {
  final properties = ref.watch(propertiesProvider) as Properties;
  var isOnline = properties.isOnline;
  if (isOnline) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Row(children: <Widget>[
              Icon(Icons.sms_failed, color: colorGreen),
              SizedBox(
                width: 10,
              ),
              Text(
                'Confirmar acción',
                style: mainBoldText,
              )
            ]),
            content: const Text(
                '¿Desea sincronizar el dispositivo con el servidor?'),
            actions: [
              // The "CANCELAR" button
              TextButton(
                  onPressed: () {
                    // Cerramos el dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'CANCELAR',
                    style: mainText,
                  )),
              // The "SÍ" button
              TextButton(
                  onPressed: () {
                    // Cerramos el dialog
                    Navigator.of(context).pop();
                    ref.read(propertiesProvider.notifier).setIsLoading(true);
                    Future.delayed(const Duration(seconds: 2), () {
                      ref.read(propertiesProvider.notifier).setIsLoading(false);
                      //Aviso de conclusión de sincronización
                      showInfo(
                        context,
                        'Aviso',
                        'Se ha sincronizado correctamente la información,\ntrasferiendo los avances de 04 inspecciones.',
                      );
                    });
                  },
                  child: const Text(
                    'SÍ',
                    style: mainText,
                  )),
            ],
          );
        });
  } else {
    showInfo(
      context,
      'Aviso',
      'Por el momento no se tiene conexión a internet\npara realizar la acción solicitada.',
    );
  }
}

void logout(BuildContext context, WidgetRef ref, bool haveCredentials) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Row(children: <Widget>[
          Icon(Icons.sms_failed, color: colorGreen),
          SizedBox(
            width: 10,
          ),
          Text(
            'Confirmar acción',
            style: mainBoldText,
          )
        ]),
        content: const Text('¿Desea cerrar su sesión?'),
        actions: [
          // The "CANCELAR" button
          TextButton(
              onPressed: () {
                // Cerramos el dialog
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCELAR',
                style: mainText,
              )),
          // The "Sí" button
          TextButton(
              onPressed: () {
                // apagamos credenciales
                desactivaCredenciales(ref);
                // Cerramos el dialog
                Navigator.of(context).pop();
                // Cargamos el route del Login
                Navigator.pop(context);
              },
              child: const Text(
                'SÍ',
                style: mainText,
              )),
        ],
      );
    },
  );
}

void desactivaCredenciales(WidgetRef ref) async {
  // Abre conexión a la base de datos
  var db = await DatabaseHelper.instance.database;
  // Desactiva las credenciales
  DatabaseHelper.instance.setCredencialesActivo(0);
  // Deshabilita la variable de control isAutorized
  ref.read(propertiesProvider.notifier).setIsAutorized(false);
}

void closing(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Row(children: <Widget>[
          Icon(Icons.sms_failed, color: colorGreen),
          SizedBox(
            width: 10,
          ),
          Text(
            'Confirmar acción',
            style: mainBoldText,
          )
        ]),
        content: const Text('¿Desea finalizar la aplicación?'),
        actions: [
          // The "CANCELAR" button
          TextButton(
              onPressed: () {
                // Cerramos el dialog
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCELAR',
                style: mainText,
              )),
          // The "SÍ" button
          TextButton(
              onPressed: () {
                // Cerramos el dialog
                Navigator.of(context).pop();
                // Salir de la aplicación
                exit(0);
              },
              child: const Text(
                'SÍ',
                style: mainText,
              )),
        ],
      );
    },
  );
}

void showInfo(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Row(children: <Widget>[
          const Icon(Icons.info, color: colorGreen),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: mainBoldText,
          )
        ]),
        content: Text(message),
        actions: [
          // The "ACEPTAR" button
          TextButton(
              onPressed: () {
                // Cerramos el dialog
                Navigator.of(context).pop();
              },
              child: const Text(
                'ACEPTAR',
                style: mainText,
              )),
        ],
      );
    },
  );
}

void login(BuildContext context, WidgetRef ref, int userCoreID) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return Form(
        key: _formKey,
        child: AlertDialog(
          title: const Row(children: <Widget>[
            Icon(Icons.sms_failed, color: colorGreen),
            SizedBox(
              width: 10,
            ),
            Text(
              'Datos requeridos',
              style: mainBoldText,
            )
          ]),
          content: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La contraseña no puede ser vacía';
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
            ),
          ),
          actions: [
            // The "CANCELAR" button
            TextButton(
                onPressed: () {
                  // Cerramos el dialog
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCELAR',
                  style: mainText,
                )),
            // The "INGRESAR" button
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkLoginOffline(
                        context, ref, userCoreID, passwordController.text);
                  }
                },
                child: const Text(
                  'INGRESAR',
                  style: mainText,
                )),
          ],
        ),
      );
    },
  );
}

void checkLoginOffline(BuildContext context, WidgetRef ref, int userCoreID,
    String password) async {
  // Cerramos el dialog
  Navigator.of(context).pop();
  //Abre conexión a la base de datos
  var db = await DatabaseHelper.instance.database;
  // Validar la contraseña almacenada
  List<Map<String, Object?>>? registros =
      await DatabaseHelper.instance.getCredencialByUserCoreId(userCoreID);
  if (registros.isNotEmpty) {
    // Recuperando la contraseña de la BD
    var contenido = registros[0];
    int? id = int.tryParse(contenido['id'].toString());
    String credencialPassword = registros[0]['password'].toString();
    // Encriptando la contraseña capturada
    final key = encrypt.Key.fromUtf8('airkey_k21l29d82id99a0mvb2saq123');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encryptedPass = encrypter.encrypt(password, iv: iv);
    if (encryptedPass.base64 == credencialPassword) {
      // Desactiva todas las credenciales y activa la actual
      DatabaseHelper.instance.setCredencialesActivo(0);
      DatabaseHelper.instance.setCredencialActivo(id, 1);
      // Habilita la variable de control isAutorized
      ref.read(propertiesProvider.notifier).setIsAutorized(true);
      // Guardar el nombre del usuario
      ref.read(propertiesProvider.notifier).setUsuarioActivo(
          contenido['nombre'] != null ? contenido['nombre'].toString() : '');
      // Redireccionar al desktop
      // ignore: use_build_context_synchronously
      routeDesktop(context);
    } else {
      // ignore: use_build_context_synchronously
      showInfo(
        context,
        'Aviso',
        'El correo electrónico o la contraseña no son válidos,\nfavor de verificarlos.',
      );
    }
  }
}
