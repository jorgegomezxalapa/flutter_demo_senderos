import 'package:flutter/material.dart';
import 'package:air_senderos/resources/colors.dart';
import 'package:air_senderos/resources/styles.dart';
import 'package:air_senderos/routes/login_route.dart';
import 'dart:io';
import 'dart:developer';

var isOnline = false;
var isLoading = false;

void sincronize(BuildContext context) {
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
                    isLoading = true;
                    log("isLoading is: $isLoading");
                    Future.delayed(const Duration(seconds: 2), () {
                      isLoading = false;
                      log("isLoading is: $isLoading");
                      //Aviso de conclusión de sincronización
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                                title: const Row(children: <Widget>[
                                  Icon(Icons.info, color: colorGreen),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Aviso',
                                    style: mainBoldText,
                                  )
                                ]),
                                content: const Text(
                                    'Se ha sincronizado correctamente la información, se han trasferido las respuestas de 23 preguntas.'),
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
                                ]);
                          });
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
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Row(children: <Widget>[
            Icon(Icons.info, color: colorGreen),
            SizedBox(
              width: 10,
            ),
            Text(
              'Aviso',
              style: mainBoldText,
            )
          ]),
          content: const Text('Por el momento no se tiene conexión a internet'),
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
}

void logout(BuildContext context) {
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
                // Cerramos el dialog
                Navigator.of(context).pop();
                // Cargamos el route del Login
                routeLogin(context);
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

void login(BuildContext context) {
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
            'Datos requeridos',
            style: mainBoldText,
          )
        ]),
        content: TextField(
          obscureText: true,
          onChanged: (value) {
            print(value);
          },
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña'),
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
                // Cerramos el dialog
                Navigator.of(context).pop();
                // Salir de la aplicación
                print("ingresar");
              },
              child: const Text(
                'INGRESAR',
                style: mainText,
              )),
        ],
      );
    },
  );
}
