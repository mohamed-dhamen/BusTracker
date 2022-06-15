import 'dart:collection';
import 'package:bustracker/services/MyMaps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Home.dart';
import 'package:flutter/cupertino.dart';
import 'Sign_in_ui.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScreen());
}
