import 'package:air_senderos/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class AlertaInformacionEnviada extends StatefulWidget {
  const AlertaInformacionEnviada({super.key});

  @override
  AlertaInformacionEnviadaState createState() =>
      AlertaInformacionEnviadaState();
}

class AlertaInformacionEnviadaState extends State<AlertaInformacionEnviada> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text('La nformación fué enviada con éxito'),
        ),
      ),
    );
  }
}
