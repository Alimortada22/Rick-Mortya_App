import 'package:flutter/material.dart';
import 'package:rick_and_mortya_app/app_routes.dart';

void main() {
  runApp( MyApp(appRoutes: AppRoutes(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.appRoutes});
final AppRoutes appRoutes;
  
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
     debugShowCheckedModeBanner: false,
     onGenerateRoute: appRoutes.generatedRoutes,
      
    );
  }
}

