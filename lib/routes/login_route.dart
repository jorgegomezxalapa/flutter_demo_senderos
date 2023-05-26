import 'package:flutter/material.dart';
//Paquete air_senderos
import 'package:air_senderos/pages/login_page.dart';
import 'package:air_senderos/pages/desktop_page.dart';
import 'package:air_senderos/pages/credentials_page.dart';

void routeLogin(context) {
  // Cerramos la page actual
  //Navigator.pop(context);
  // Cargamos la nueva page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

void routeCredentials(context) {
  // Cerramos la page actual
  //Navigator.pop(context);
  // Cargamos la nueva page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CredentialsPage(),
    ),
  );
}

void routereplaceCredentials(context) {
  // Cerramos la page actual
  //Navigator.pop(context);
  // Cargamos la nueva page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => CredentialsPage(),
    ),
  );
}

void routeDesktop(context) {
  // Cerramos la page actual
  //Navigator.pop(context);
  // Cargamos la nueva page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DesktopPage(),
    ),
  );
}
