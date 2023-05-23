import 'package:air_senderos/widgets/alerta_informacion_enviada.dart';
import 'package:air_senderos/main.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? titleText;
  final bool? btnRegresar;
  const CustomAppBar({Key? key, this.titleText, this.btnRegresar})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  bool _hasConnection = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnection();
    });
  }

  void _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.other) {
      setState(() {
        _hasConnection = true;
      });
    } else {
      setState(() {
        _hasConnection = false;
      });
    }
    log("_hasConnection is: $_hasConnection");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.btnRegresar ?? true,
      title: Text(widget.titleText ?? 'Flutter App'),
      actions: [
        SafeArea(
            child: ButtonBar(
          children: [
            IconButton(
                onPressed: () {
                  if (_hasConnection) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Enviar información capturada'),
                              content: const Text(
                                  'Esta acción envía la información a la nube y posteriormente la elimina del dispositivo, Desea continuar?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancelar'),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AlertaInformacionEnviada(),
                                      )),
                                  child: const Text('Confirmar'),
                                ),
                              ],
                            ));
                  }
                },
                icon: Icon(
                  _hasConnection ? Icons.cloud_upload : Icons.cloud_off,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                icon: const Icon(Icons.home)),
          ],
        )),
      ],
    );
  }
}
