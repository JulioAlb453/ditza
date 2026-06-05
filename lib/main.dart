import 'package:device_preview/device_preview.dart';
import 'package:ditza/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => Ditza(sharedPrefs: sharedPrefs),
    ),
  );
}
