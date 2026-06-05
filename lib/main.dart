import 'package:device_preview/device_preview.dart';
import 'package:ditza/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => const Ditza(),
    ),
  );
}
