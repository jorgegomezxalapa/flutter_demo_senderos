import 'package:air_senderos/resources/designs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
//Paquete air_senderos
import 'package:air_senderos/main.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/resources/designs/styles.dart';
import 'package:air_senderos/resources/scripts/general.dart';
import 'package:air_senderos/routes/login_route.dart';
import 'package:air_senderos/pages/widgets/component_progress_indicator.dart';
import 'package:air_senderos/resources/scripts/config.dart';
import 'package:air_senderos/database/handler/database_helper.dart';
import 'package:air_senderos/database/models/credencial.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var isLoading = properties.isLoading;
    var haveCredentials = properties.haveCredentials;
    var version = properties.version;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(250, 35, 91, 78),
        title: Text(AppLocalizations.of(context)!.appBar(version)),
        actions: [
          Visibility(
            visible: haveCredentials,
            child: IconButton(
              icon: const Icon(
                Icons.people,
                size: 35,
              ),
              tooltip: 'Credenciales',
              onPressed: () {
                Navigator.pop(context);
                //routeCredentials(context);
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 35,
            ),
            tooltip: 'Finalizar aplicación',
            onPressed: () {
              closing(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        // demo of some additional parameters
        opacity: 0.5,
        blur: 5,
        progressIndicator: const ComponentProgressIndicator(
          title: '¡Espere un momento!',
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                        width: 300,
                        height: 150,
                        child: /*Image.asset(
                            './assets/images/logo-color-mails.jpg')*/
                            SvgPicture.asset('assets/images/logo.svg')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.generalIniciarSesion,
                    style: titleText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 20),
                  child: Text(
                    AppLocalizations.of(context)!.generalAccede(version),
                    style: subtitleText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El correo electrónico no puede ser vacío';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo electrónico',
                        hintText:
                            'Ingresa tu correo electrónico válido. Ej. abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20, bottom: 20),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La contraseña no puede ser vacía';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                        hintText: 'Ingresa tu contraseña'),
                  ),
                ),
                TextButton(
                  style:
                      isOnline ? mainFlatButtonStyle : secondaryFlatButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isOnline) {
                        validateLogin(context, ref);
                      } else {
                        showInfo(
                          context,
                          'Aviso',
                          'Por el momento no se tiene conexión a internet\npara realizar la acción solicitada.',
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: colorGreen,
                            content: Text(
                                'Favor de capturar la información solictada')),
                      );
                    }
                  },
                  child: const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.lock),
                      Text(' INGRESAR'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateLogin(BuildContext context, WidgetRef ref) async {
    final client = RetryClient(http.Client());
    final properties = ref.watch(propertiesProvider) as Properties;
    var haveCredentials = properties.haveCredentials;
    //PASO 0. Activar el loading mientras se válida el usuario contraseña para bloquear la interfaz
    ref.read(propertiesProvider.notifier).setIsLoading(true);
    //PASO 1. Realizar conexión al core para obtener un access token
    try {
      var access_token;
      var data = {
        "grant_type": "client_credentials",
        "client_id": coreServiceClientID,
        "client_secret": coreServiceClientSecret,
        "scope": "*"
      };
      var response = await client.post(Uri.parse("$coreService/oauth/token"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE",
          },
          body: json.encode(data),
          encoding: Encoding.getByName("utf-8"));

      if (response.statusCode == 200) {
        // Exito en el consumo del servicio
        var contenido = json.decode(response.body);
        print(contenido);
        if (contenido['access_token'] != null) {
          access_token = contenido['access_token'];
          //PASO 2. Recuperar valores de usuario y contraseña
          String email = emailController.text;
          String pass = passwordController.text;
          //PASO 3. Consumir el servicio de validación de usuario y contraseña
          var data = {
            "email": email,
            "password": pass,
          };
          var response = await client.post(
              Uri.parse("$coreService/api/usuarios/autenticar"),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Credentials": "true",
                "Access-Control-Allow-Headers": "Content-Type",
                "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE",
                "Authorization": "Bearer $access_token",
              },
              body: json.encode(data),
              encoding: Encoding.getByName("utf-8"));
          //PASO 4. Validar la respuesta del servidor
          if (response.statusCode == 200) {
            //PASO 411. Si es correcta la validación guardar la credencial
            var contenido = json.decode(response.body);
            print(contenido);
            if (contenido['id'] != null) {
              print(contenido['id']);
              print(contenido['first_name']);
              print(contenido['last_name']);
              print(contenido['second_last_name']);
              print(contenido['token_session']);
              //Abre conexión a la base de datos
              var db = await DatabaseHelper.instance.database;
              int? id;
              // Valida si existe el usuario previamente
              List<Map<String, Object?>>? registros = await DatabaseHelper
                  .instance
                  .getCredencialByUserCoreId(contenido['id']);
              if (registros.isNotEmpty) {
                print("Viejo registro");
                id = int.tryParse(registros[0]['id'].toString());
              } else {
                print("Nuevo registro");
                // Encriptando la contraseña
                final key =
                    encrypt.Key.fromUtf8('airkey_k21l29d82id99a0mvb2saq123');
                final iv = encrypt.IV.fromLength(16);
                final encrypter = encrypt.Encrypter(encrypt.AES(key));
                final encryptedPass = encrypter.encrypt(pass, iv: iv);
                // Sino existe, inserta un registro en la tabla personas
                id = await DatabaseHelper.instance.insertCredencial({
                  DatabaseHelper.columnCredencialUserCoreId: contenido['id'],
                  DatabaseHelper.columnCredencialActivo: 0,
                  DatabaseHelper.columnCredencialNombre:
                      contenido['first_name'],
                  DatabaseHelper.columnCredencialPrimerApellido:
                      contenido['last_name'],
                  DatabaseHelper.columnCredencialSegundoApellido:
                      contenido['second_last_name'],
                  DatabaseHelper.columnCredencialUsuario: email,
                  DatabaseHelper.columnCredencialPassword: encryptedPass.base64,
                  DatabaseHelper.columnCredencialToken:
                      contenido['token_session']
                });
                /*
                Credencial credencialNueva = Credencial(
                  activo: 0,
                  userCoreId: contenido['id'],
                  nombre: contenido['first_name'],
                  primerApellido: contenido['last_name'],
                  segundoApellido: contenido['second_last_name'],
                  usuario: email,
                  password: encryptedPass.base64,
                  token: contenido['token_session'],
                );
                Credencial credencialGuardada = await DatabaseHelper.instance
                    .createCredencial(credencialNueva);
                id = credencialGuardada.id;
                */
              }
              //PASO 412. Desactiva todas las credenciales y activa la actual
              print("Desactiva todas las credenciales");
              DatabaseHelper.instance.setCredencialesActivo(0);
              print("Activa la credencial $id");
              DatabaseHelper.instance.setCredencialActivo(id, 1);
              //PASO 413. Habilita la variable de control isAutorized
              ref.read(propertiesProvider.notifier).setIsAutorized(true);
              //PASO 414. Guardar el nombre del usuario
              ref.read(propertiesProvider.notifier).setUsuarioActivo(
                  contenido['first_name'] != null
                      ? contenido['first_name']
                      : '');
              //PASO 416. Habilita que se tienen credenciales registradas y limpia la pagina del login del Navigator
              if (!haveCredentials) {
                routeCredentials(context);
              } else {
                Navigator.pop(context);
              }
              ref.read(propertiesProvider.notifier).setHaveCredentials(true);
              //PASO 417. Redireccionar al desktop
              routeDesktop(context);
            }
          } else if (response.statusCode == 422) {
            //PASO 421. Si es incorrecta mostrar leyenda de error
            // ignore: use_build_context_synchronously
            showInfo(
              context,
              'Aviso',
              'El correo electrónico o la contraseña no son válidos,\nfavor de verificarlos.',
            );
          } else {
            // ignore: use_build_context_synchronously
            showInfo(
              context,
              'Aviso',
              'Fallo el proceso de autentificación,\nfavor de intentar más tarde.',
            );
          }
        }
      } else {
        // ignore: use_build_context_synchronously
        showInfo(
          context,
          'Aviso',
          'Fallo el proceso de autentificación,\nfavor de intentar más tarde.',
        );
      }
      //PASO 4. Liberación del loading
      ref.read(propertiesProvider.notifier).setIsLoading(false);
    } catch (e) {
      if (e is SocketException) {
        showInfo(
          context,
          'Error de conexión',
          e.toString(),
        );
      } else if (e is TimeoutException) {
        showInfo(
          context,
          'Error tiempo agotado',
          e.toString(),
        );
      } else {
        showInfo(
          context,
          'Error',
          e.toString(),
        );
      }
      ref.read(propertiesProvider.notifier).setIsLoading(false);
    } finally {
      client.close();
    }
  }
}
