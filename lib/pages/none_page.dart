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

class NonePage extends ConsumerWidget {
  const NonePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isLoading = properties.isLoading;
    var version = properties.version;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(250, 35, 91, 78),
        title: Text(AppLocalizations.of(context)!.appBar(version)),
        actions: [
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
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '',
                    style: titleText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
