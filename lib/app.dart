import 'package:flutter/material.dart';
import 'core/shared/theme.dart';
import 'core/shared/util.dart';
import 'core/navigation/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bodyFont = 'Montserrat';
    const displayFont = 'Montserrat';

    final textTheme = createTextTheme(context, bodyFont, displayFont);
    
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Ditza',
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
