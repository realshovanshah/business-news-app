import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:business_news/app/router/app_router.dart' as router;

/// {@template app}
///  Entry point of the application.
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro app}
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 730),
      builder: () => const MaterialApp(
        title: 'Swivt Assignment',
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
