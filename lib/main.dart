import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
//Paquete air_senderos
import 'package:air_senderos/resources/designs/colors.dart';
import 'package:air_senderos/providers/properties.dart';
import 'package:air_senderos/pages/none_page.dart';
import 'package:air_senderos/pages/login_page.dart';
import 'package:air_senderos/pages/desktop_page.dart';
import 'package:air_senderos/pages/credentials_page.dart';
import 'package:air_senderos/database/handler/database_helper.dart';

final propertiesProvider = StateNotifierProvider(
      (ref) => PropertiesNotifier(
    const Properties(
        version: '0.1',
        isOnline: false,
        isLoading: false,
        isAutorized: false,
        haveCredentials: false,
        checkCredentials: false,
        usuarioActivo: ""),
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
        title: 'AIR App',
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
  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnection();
    });
    _checkCredenciales(ref);
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
  }

  void _checkCredenciales(WidgetRef ref) async {
    // Abre conexión a la base de datos
    var db = await DatabaseHelper.instance.database;
    // Desactiva las credenciales
    List<Map<String, Object?>>? registros =
    await DatabaseHelper.instance.getCredenciales();
    if (registros.isNotEmpty) {
      // Deshabilita la variable de control isAutorized
      ref.read(propertiesProvider.notifier).setHaveCredentials(true);
    }
    ref.read(propertiesProvider.notifier).setCheckCredentials(true);
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertiesProvider) as Properties;
    var isOnline = properties.isOnline;
    var isAutorized = properties.isAutorized;
    var haveCredentials = properties.haveCredentials;
    var checkCredentials = properties.checkCredentials;
    return isAutorized
        ? DesktopPage()
        : checkCredentials
        ? (haveCredentials ? CredentialsPage() : LoginPage())
        : NonePage();
  }
}
