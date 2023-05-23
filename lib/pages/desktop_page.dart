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

class DesktopPage extends ConsumerWidget {
  const DesktopPage({super.key});
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
          IconButton(
            icon: isOnline
                ? const Icon(
                    Icons.cloud_upload,
                    size: 35,
                  )
                : const Icon(
                    Icons.cloud_off,
                    size: 35,
                  ),
            tooltip: 'Sincronizar',
            onPressed: () {
              sincronize(context);
            },
          ),
          Visibility(
            visible: isOnline,
            child: IconButton(
              icon: const Icon(
                Icons.person_off,
                size: 35,
              ),
              tooltip: 'Cerrar sesión',
              onPressed: () {
                logout(context);
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
                    'Inspecciones',
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
                    'Seleccione un cuestionario para continuar',
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
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Cuestionario1Page()),
                            );
                            */
                          },
                          child: const ListTile(
                              title: Text("Cuestionario 1"),
                              subtitle: Text(
                                  "Recolección de impresiones de la votación."),
                              leading: Text(
                                '01',
                                style: titleText,
                              ),
                              trailing: Icon(Icons.star)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Cuestionario2Page()),
                            );
                            */
                          },
                          child: const ListTile(
                              title: Text("Cuestionario 2"),
                              subtitle: Text("Registro de incidencias."),
                              leading: Text(
                                '02',
                                style: titleText,
                              ),
                              trailing: Icon(Icons.star)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            // ignore: avoid_print
                            print("tapped 3");
                          },
                          child: const ListTile(
                              title: Text("Cuestionario 3"),
                              subtitle:
                                  Text("Incongruencias en las votaciones."),
                              leading: Text(
                                '03',
                                style: titleText,
                              )))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            // ignore: avoid_print
                            print("tapped 4");
                          },
                          child: const ListTile(
                              title: Text("Cuestionario 4"),
                              subtitle: Text(
                                  "Confirmación de identidad de la empresa."),
                              leading: Text(
                                '04',
                                style: titleText,
                              ))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
