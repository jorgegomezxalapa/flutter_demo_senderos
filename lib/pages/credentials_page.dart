import 'package:air_senderos/routes/login_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Paquete air_senderos
import 'package:air_senderos/main.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/resources/styles.dart';
import 'package:air_senderos/resources/general.dart';
import 'package:air_senderos/pages/widgets/component_progress_indicator.dart';

class CredentialsPage extends ConsumerWidget {
  const CredentialsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var version = properties.version;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(250, 35, 91, 78),
        title: Text(AppLocalizations.of(context).appBar(version)),
        actions: [
          Visibility(
            visible: isOnline,
            child: IconButton(
              icon: const Icon(
                Icons.person_add,
                size: 35,
              ),
              tooltip: 'Iniciar sesión',
              onPressed: () {
                routeLogin(context);
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Credenciales',
                    style: titleText,
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Seleccione su credencial para ingresar',
                    style: subtitleText,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true, // use this
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  Card(
                      child: InkWell(
                          onTap: () {
                            login(context);
                          },
                          child: const ListTile(
                              title: Text("Martínez Flores, Esperanza"),
                              subtitle: Text(
                                  "Recolección de impresiones de la votación."),
                              leading: Icon(
                                Icons.person,
                                size: 40,
                              ),
                              trailing: Icon(Icons.star)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            login(context);
                          },
                          child: const ListTile(
                              title: Text("Gutiérrez García, Guillermo"),
                              subtitle: Text("Registro de incidencias."),
                              leading: Icon(
                                Icons.person,
                                size: 40,
                              ),
                              trailing: Icon(Icons.star)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            login(context);
                          },
                          child: const ListTile(
                            title: Text("Castro Castro, Guadalupe"),
                            subtitle: Text("Incongruencias en las votaciones."),
                            leading: Icon(
                              Icons.person,
                              size: 40,
                            ),
                          ))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            login(context);
                          },
                          child: const ListTile(
                            title: Text("Jiménez Mejía, Marina"),
                            subtitle: Text(
                                "Confirmación de identidad de la empresa."),
                            leading: Icon(
                              Icons.person,
                              size: 40,
                            ),
                          )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
