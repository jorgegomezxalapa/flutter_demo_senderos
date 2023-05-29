import 'package:air_senderos/routes/login_route.dart';
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
import 'package:air_senderos/database/handler/database_helper.dart';

class CredentialsPage extends ConsumerWidget {
  const CredentialsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var isLoading = properties.isLoading;
    var version = properties.version;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(250, 35, 91, 78),
        title: Text(AppLocalizations.of(context)!.appBar(version)),
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
                    'Seleccione su credencial y capture su contraseña para ingresar',
                    style: subtitleText,
                  ),
                ),
              ),
              FutureBuilder<List?>(
                future: loadCredenciales(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('');
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: subtitleText,
                        );
                      }
                      List data = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                login(
                                    context, ref, data[index]['user_core_id']);
                              },
                              child: ListTile(
                                title: Text(data[index]['primer_apellido'] +
                                    (data[index]['segundo_apellido'] != null
                                        ? ' ' + data[index]['segundo_apellido']
                                        : '') +
                                    (data[index]['nombre'] != null
                                        ? ', ' + data[index]['nombre']
                                        : '')),
                                subtitle: Text(data[index]['usuario']),
                                leading: const Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                                trailing: data[index]['activo'] == 1
                                    ? const Icon(Icons.star)
                                    : null,
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> loadCredenciales() async {
    //Abre conexión a la base de datos
    var db = await DatabaseHelper.instance.database;
    return await DatabaseHelper.instance.getCredenciales();
  }
}
