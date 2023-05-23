import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Paquete air_senderos
import 'package:air_senderos/main.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/resources/styles.dart';
import 'package:air_senderos/resources/general.dart';
import 'package:air_senderos/pages/desktop_page.dart';
import 'package:air_senderos/routes/login_route.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var haveCredentials = properties.haveCredentials;
    var version = properties.version;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(250, 35, 91, 78),
          title: Text(AppLocalizations.of(context).appBar(version)),
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
                  routeCredentials(context);
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                      width: 200,
                      height: 150,
                      child:
                          Image.asset('./assets/images/logo-color-mails.jpg')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context).generalIniciarSesion,
                  style: titleText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                child: Text(
                  AppLocalizations.of(context).generalAccede(version),
                  style: subtitleText,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico',
                      hintText:
                          'Ingresa tu correo electrónico válido. Ej. abc@gmail.com'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20, bottom: 20),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: 'Ingresa tu contraseña'),
                ),
              ),
              TextButton(
                style: mainFlatButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DesktopPage()),
                  );
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
        ));
  }
}
