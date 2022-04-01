import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/constants.dart';
import 'screens/login_screen.dart';
import 'screens/reserve_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MaterialApp(
    localizationsDelegates: [GlobalMaterialLocalizations.delegate],
    supportedLocales: [const Locale('en', 'US'), const Locale('fr', 'FR')],
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "Tajawal",
    ),
    home:
        Directionality(textDirection: TextDirection.rtl, child: LoginScreen()),
  ));
}
