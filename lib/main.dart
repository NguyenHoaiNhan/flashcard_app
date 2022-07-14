import 'package:flashcard_app/route/app_router.dart';
import 'package:flashcard_app/route/route_names.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LandingPage(),
      initialRoute: RouteNames.landingPage,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
