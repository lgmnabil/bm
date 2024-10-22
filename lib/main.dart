import 'package:flutter/material.dart';
import 'package:rm_bloc/app_router.dart';

void main() {
  runApp(RnMApp(appRouter: AppRouter()));
}

class RnMApp extends StatelessWidget {
  const RnMApp({super.key, required this.appRouter});
   final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

