import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
//Paquete air_senderos
import 'package:air_senderos/services/api_paises.dart';
import 'package:air_senderos/pages/modulo_persona.dart';
import 'package:air_senderos/resources/colors.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/pages/login_page.dart';
import 'package:air_senderos/pages/desktop_page.dart';
import 'package:air_senderos/pages/credentials_page.dart';
import 'dart:developer';

final propertiesProvider = StateNotifierProvider(
  (ref) => PropertiesNotifier(
    const Properties(
        version: '0.1',
        isOnline: false,
        isLoading: false,
        isAutorized: true,
        haveCredentials: true),
  ),
);

Future main() async {
  if (Platform.isWindows) {
    // Initialize FFI
    ffi.sqfliteFfiInit();
    // Change the default factory
    databaseFactory = ffi.databaseFactoryFfi;
  }
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter App',
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        localeListResolutionCallback: (locales, supportedLocales) {
          return const Locale('es');
        },
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: colorGreen),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  void _routeFormularioPersona() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ModuloPersona()));
  }

  void _routeApiPaises() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ApiPaises()));
  }

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
      ref.read(propertiesProvider.notifier).setIsOnline(true);
    } else {
      ref.read(propertiesProvider.notifier).setIsOnline(false);
    }
    /**********************************************************************************/
    /******************************     SOLO PRUEBAS     ******************************/
    /**********************************************************************************/
    final properties = ref.watch(propertiesProvider) as Properties;
    log("Properties is: $properties");
    var isOnline = properties.isOnline;
    log("isOnline is: $isOnline");
    /**********************************************************************************/
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var isAutorized = properties.isAutorized;
    var haveCredentials = properties.haveCredentials;
    return isAutorized
        ? (haveCredentials ? const CredentialsPage() : const LoginPage())
        : const DesktopPage();
  }
}
