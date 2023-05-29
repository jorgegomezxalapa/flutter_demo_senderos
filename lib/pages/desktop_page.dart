import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Paquete air_senderos
import 'package:air_senderos/main.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/resources/designs/styles.dart';
import 'package:air_senderos/resources/scripts/general.dart';
import 'package:air_senderos/pages/widgets/component_progress_indicator.dart';

class DesktopPage extends ConsumerWidget {
  const DesktopPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var isLoading = properties.isLoading;
    var version = properties.version;
    var haveCredentials = properties.haveCredentials;
    var usuarioActivo = properties.usuarioActivo;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(250, 35, 91, 78),
        title: Text(AppLocalizations.of(context)!.appBar(version)),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 0),
            child: Text(
              textAlign: TextAlign.right,
              "¡Bienvenidx!\n$usuarioActivo",
            ),
          ),
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
              sincronize(context, ref);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_off,
              size: 35,
            ),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              logout(context, ref, haveCredentials);
            },
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
                    'Mis inspecciones',
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
                    'Seleccione la inspección que desea trabajar',
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
                            print("tapped 1");
                          },
                          child: const ListTile(
                              title: Text("221/000108/2023"),
                              subtitle: Text("18 mayo 2023 Hora: 12:00 p. m."),
                              leading: Text(
                                '01',
                                style: titleText,
                              ),
                              trailing: Icon(Icons.done)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            print("tapped 2");
                          },
                          child: const ListTile(
                              title: Text("221/000102/2023"),
                              subtitle: Text("16 mayo 2023 Hora: 12:00 p. m."),
                              leading: Text(
                                '02',
                                style: titleText,
                              ),
                              trailing: Icon(Icons.done)))),
                  Card(
                      child: InkWell(
                          onTap: () {
                            // ignore: avoid_print
                            print("tapped 3");
                          },
                          child: const ListTile(
                              title: Text("221/000044/2023"),
                              subtitle: Text("20 abril 2023 Hora: 12:00 p. m."),
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
                              title: Text("221/000074/2023"),
                              subtitle: Text("30 marzo 2023 Hora: 08:00 a. m."),
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
